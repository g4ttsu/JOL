package net.deckserver.rest;

import net.deckserver.JolAdmin;
import net.deckserver.game.enums.PlayerRole;
import net.deckserver.services.*;
import net.deckserver.storage.json.system.PlayerInfo;
import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVPrinter;
import org.apache.commons.csv.QuoteMode;
import net.deckserver.storage.json.system.GameHistory;
import net.deckserver.storage.json.system.PlayerResult;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import java.io.IOException;
import java.io.StringWriter;
import java.time.LocalDate;
import java.time.OffsetDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.function.Function;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Path("/admin")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class AdminResource extends BaseResource {

    /**
     * Replaces DS.setRole()
     */
    @PUT
    @Path("player/{name}/role")
    public Map<String, Object> setRole(@PathParam("name") String player, SetRoleRequest body) {
        String playerName = username();
        PlayerInfo target = PlayerService.get(player);
        if (JolAdmin.isAdmin(playerName)) {
            JolAdmin.setRole(target, PlayerRole.valueOf(body.role()), body.value());
        }
        return update(playerName);
    }

    /**
     * Replaces DS.deletePlayer()
     */
    @DELETE
    @Path("player/{name}")
    public Map<String, Object> deletePlayer(@PathParam("name") String targetPlayer) {
        String player = username();
        if (JolAdmin.isAdmin(player)) {
            JolAdmin.deletePLayer(targetPlayer);
        }
        return update(player);
    }

    /**
     * Replaces DS.setMessage()
     */
    @POST
    @Path("message")
    public Map<String, Object> setMessage(MessageRequest body) {
        String playerName = username();
        // message setting is a no-op in current impl but retained for compatibility
        return update(playerName);
    }

    /**
     * Replaces DS.getVekn()
     */
    @GET
    @Path("player/{name}/vekn")
    public String getVekn(@PathParam("name") String playerName) {
        username(); // auth check
        return PlayerService.get(playerName).getVeknId();
    }

    /**
     * Replaces DS.exportPastGamesAsCsv()
     */
    @GET
    @Path("export/games.csv")
    @Produces(MediaType.TEXT_PLAIN)
    public String exportPastGamesAsCsv() throws IOException {
        username(); // auth check
        CSVFormat format = CSVFormat.DEFAULT.builder()
                .setHeader("Game", "Started", "Ended", "Player", "Deck", "GW", "VP")
                .setQuoteMode(QuoteMode.ALL)
                .build();
        StringWriter writer = new StringWriter();
        CSVPrinter printer = new CSVPrinter(writer, format);
        DateTimeFormatter csvDateTimeFormatter = DateTimeFormatter.ofPattern("d MMM uuuu HH:mm");
        Map<OffsetDateTime, GameHistory> history = HistoryService.getHistory();
        if (history.isEmpty()) {
            return "NO DATA AVAILABLE";
        }
        for (GameHistory game : history.values()) {
            for (PlayerResult player : game.getResults()) {
                String startTime = OffsetDateTime.parse(game.getStarted(), DateTimeFormatter.ISO_OFFSET_DATE_TIME).format(csvDateTimeFormatter);
                String endTime = OffsetDateTime.parse(game.getEnded(), DateTimeFormatter.ISO_OFFSET_DATE_TIME).format(csvDateTimeFormatter);
                printer.printRecord(game.getName(), startTime, endTime, player.getPlayerName(), player.getDeckName(),
                        player.isGameWin() ? "GW" : "", String.valueOf(player.getVP()).replace(".", ","));
            }
        }
        return writer.toString();
    }

    @POST
    @Path("stats")
    public Map<String, List<String>> getStatsPerPlayer(StatsRequest body) {
        return getStats(body, this::generateStats);
    }

    @POST
    @Path("stats/deck")
    public Map<String, List<String>> getStatsPerDeck(StatsRequest body) {
        return getStats(body, this::generateStatsPerDeck);
    }

    @GET
    @Path("metrics/player")
    public Map<String, List<Long>> getMetricsPlayer(@QueryParam("fromDate") String fromDate, @QueryParam("toDate") String toDate) {
        return getMetrics(
                fromDate,
                toDate,
                MetricsService.load(),
                MetricsService.PlayerMetricDto::playerName
        );
    }

    @GET
    @Path("metrics/game")
    public Map<String, List<Long>> getMetricsGame(@QueryParam("fromDate") String fromDate, @QueryParam("toDate") String toDate) {
        return getMetrics(
                fromDate,
                toDate,
                MetricsService.load(),
                MetricsService.PlayerMetricDto::gameName
        );
    }

    @GET
    @Path("commands/player")
    public Map<String, List<Long>> getCommandsPlayer(@QueryParam("fromDate") String fromDate, @QueryParam("toDate") String toDate) {
        return getCommands(
                fromDate,
                toDate,
                MetricsService.loadCommands(),
                MetricsService.CommandMetricDto::playerName
        );
    }

    @GET
    @Path("commands/game")
    public Map<String, List<Long>> getCommandsGame(@QueryParam("fromDate") String fromDate, @QueryParam("toDate") String toDate) {
        return getCommands(
                fromDate,
                toDate,
                MetricsService.loadCommands(),
                MetricsService.CommandMetricDto::game
        );
    }

    /**
     * Sets the global site notes shown on the main page.
     */
    @PUT
    @Path("site-notes")
    public Map<String, Object> setSiteNotes(SiteNotesRequest body) {
        String playerName = username();
        if (JolAdmin.isAdmin(playerName)) {
            SiteNotesService.setNotes(body.notes());
        }
        return update(playerName);
    }

    /**
     * Clears the global site notes.
     */
    @DELETE
    @Path("site-notes")
    public Map<String, Object> clearSiteNotes() {
        String playerName = username();
        if (JolAdmin.isAdmin(playerName)) {
            SiteNotesService.clear();
        }
        return update(playerName);
    }

    public record SetRoleRequest(String role, boolean value) {
    }

    public record MessageRequest(String message) {
    }

    public record SiteNotesRequest(String notes) {
    }

    public record StatsRequest(int treshold, String fromDate, String toDate, boolean isTourney) {
    }

    private Map<String, List<String>> getStats(StatsRequest body, StatsGenerator generator) {
        Map<OffsetDateTime, GameHistory> history = HistoryService.getHistory();
        Map<String, Integer> gw = new HashMap<>();
        Map<String, Double> vp = new HashMap<>();
        Map<String, Integer> games = new HashMap<>();

        if (body.isTourney()) {
            for (GameHistory game : history.values()) {
                if (game.getName().contains("Final Table") ||
                        Pattern.compile("Round\\s+\\d+\\s*-\\s*Table\\s+\\d+").matcher(game.getName()).find()) {
                    if (body.fromDate().isEmpty() || body.toDate().isEmpty()) {
                        generator.generate(game, gw, vp, games);
                    } else {
                        LocalDate ended = OffsetDateTime.parse(game.getEnded()).toLocalDate();
                        if (ended.isAfter(LocalDate.parse(body.fromDate())) && ended.isBefore(LocalDate.parse(body.toDate()))) {
                            generator.generate(game, gw, vp, games);
                        }
                    }
                }
            }
        } else {
            for (GameHistory game : history.values()) {
                if (body.fromDate().isEmpty() || body.toDate().isEmpty()) {
                    generator.generate(game, gw, vp, games);
                } else {
                    LocalDate ended = OffsetDateTime.parse(game.getEnded()).toLocalDate();
                    if (ended.isAfter(LocalDate.parse(body.fromDate())) && ended.isBefore(LocalDate.parse(body.toDate()))) {
                        generator.generate(game, gw, vp, games);
                    }
                }
            }
        }


        Set<String> allKeys = Stream.of(games, gw, vp)
                .flatMap(map -> map.keySet().stream())
                .collect(Collectors.toSet());

        return allKeys.stream()
                .collect(Collectors.toMap(
                        Function.identity(),
                        key -> Stream.of(
                                        String.valueOf(games.get(key)),
                                        String.valueOf(gw.get(key) == null ? "-" : gw.get(key)),
                                        String.valueOf(vp.get(key) == null ? "-" : vp.get(key)),
                                        gw.get(key) != null ? Math.round((Double.valueOf(gw.get(key)) / Double.valueOf(games.get(key))) * 100) + "%" : "0%",
                                        String.format("%.2f", vp.get(key) / Double.valueOf(games.get(key))))
                                .filter(value -> games.get(key) >= body.treshold())
                                .toList()));
    }

    private void generateStats(GameHistory game, Map<String, Integer> gw, Map<String, Double> vp, Map<String, Integer> games) {
        for (PlayerResult player : game.getResults()) {
            String name = player.getPlayerName();
            games.merge(name, 1, Integer::sum);
            vp.merge(name, player.getVictoryPoints() > 6 ? 6 : player.getVictoryPoints(), Double::sum);
            if (player.isGameWin()) {
                gw.merge(name, 1, Integer::sum);
            }
        }
    }

    private void generateStatsPerDeck(GameHistory game, Map<String, Integer> gw, Map<String, Double> vp, Map<String, Integer> games) {
        for (PlayerResult result : game.getResults()) {
            String name = result.getDeckName() + " / " + result.getPlayerName();
            //merge
            games.merge(name, 1, Integer::sum);
            vp.merge(name, result.getVictoryPoints() > 6 ? 6 : result.getVictoryPoints(), Double::sum);
            if (result.isGameWin()) {
                gw.merge(name, 1, Integer::sum);
            }
        }
    }

    @FunctionalInterface
    private interface StatsGenerator {
        void generate(GameHistory game,
                      Map<String, Integer> gw,
                      Map<String, Double> vp,
                      Map<String, Integer> games);
    }

    private Map<String, List<Long>> getMetrics(
            String fromDate, String toDate,
            List<MetricsService.PlayerMetricDto> load,
            Function<MetricsService.PlayerMetricDto, String> keyExtractor) {

        return load.stream()
                .filter(data -> {
                            if(!fromDate.equals("") && !toDate.equals("")) {
                                return data.timestamp().toLocalDate().isAfter(LocalDate.parse(fromDate)) &&
                                        data.timestamp().toLocalDate().isBefore(LocalDate.parse(toDate));
                            }
                            return true;
                        })
                .collect(Collectors.groupingBy(
                        keyExtractor,
                        Collectors.collectingAndThen(
                                Collectors.toList(),
                                list -> List.of(
                                        (long) list.size(),
                                        list.stream()
                                                .filter(MetricsService.PlayerMetricDto::didChat)
                                                .count(),
                                        list.stream()
                                                .filter(MetricsService.PlayerMetricDto::didCommand)
                                                .count(),
                                        list.stream()
                                                .filter(dto -> dto.didCommand() && dto.didChat())
                                                .count(),
                                        list.stream()
                                                .filter(dto -> dto.didPing())
                                                .count()
                                )
                        )
                ));
    }

    private Map<String, List<Long>> getCommands(
            String fromDate, String toDate,
            List<MetricsService.CommandMetricDto> load,
            Function<MetricsService.CommandMetricDto, String> keyExtractor) {
        return MetricsService.loadCommands().stream()
                .filter(data -> {
                    if(!fromDate.equals("") && !toDate.equals("")) {
                        return data.timestamp().toLocalDate().isAfter(LocalDate.parse(fromDate)) &&
                                data.timestamp().toLocalDate().isBefore(LocalDate.parse(toDate));
                    }
                    return true;
                })
                .collect(Collectors.groupingBy(
                        keyExtractor,
                        Collectors.collectingAndThen(
                                Collectors.toList(),
                                list -> List.of(
                                        list.stream()
                                                .filter(cmd -> cmd.command().startsWith("timeout"))
                                                .count(),
                                        list.stream()
                                                .filter(cmd -> cmd.command().startsWith("vp"))
                                                .count(),
                                        list.stream()
                                                .filter(cmd -> cmd.command().startsWith("choose"))
                                                .count(),
                                        list.stream()
                                                .filter(cmd -> cmd.command().startsWith("reveal"))
                                                .count(),
                                        list.stream()
                                                .filter(cmd -> cmd.command().startsWith("label"))
                                                .count(),
                                        list.stream()
                                                .filter(cmd -> cmd.command().startsWith("votes"))
                                                .count(),
                                        list.stream()
                                                .filter(cmd -> cmd.command().startsWith("random"))
                                                .count(),
                                        list.stream()
                                                .filter(cmd -> cmd.command().startsWith("flip"))
                                                .count(),
                                        list.stream()
                                                .filter(cmd -> cmd.command().startsWith("discard"))
                                                .count(),
                                        list.stream()
                                                .filter(cmd -> cmd.command().startsWith("draw"))
                                                .count(),
                                        list.stream()
                                                .filter(cmd -> cmd.command().startsWith("edge"))
                                                .count(),
                                        list.stream()
                                                .filter(cmd -> cmd.command().startsWith("play"))
                                                .count(),
                                        list.stream()
                                                .filter(cmd -> cmd.command().startsWith("influence"))
                                                .count(),
                                        list.stream()
                                                .filter(cmd -> cmd.command().startsWith("move"))
                                                .count(),
                                        list.stream()
                                                .filter(cmd -> cmd.command().startsWith("burn"))
                                                .count(),
                                        list.stream()
                                                .filter(cmd -> cmd.command().startsWith("pool"))
                                                .count(),
                                        list.stream()
                                                .filter(cmd -> cmd.command().startsWith("blood"))
                                                .count(),
                                        list.stream()
                                                .filter(cmd -> cmd.command().startsWith("contest"))
                                                .count(),
                                        list.stream()
                                                .filter(cmd -> cmd.command().startsWith("disc"))
                                                .count(),
                                        list.stream()
                                                .filter(cmd -> cmd.command().startsWith("capacity"))
                                                .count(),
                                        list.stream()
                                                .filter(cmd -> cmd.command().startsWith("unlock"))
                                                .count(),
                                        list.stream()
                                                .filter(cmd -> cmd.command().startsWith("lock"))
                                                .count(),
                                        list.stream()
                                                .filter(cmd -> cmd.command().startsWith("order"))
                                                .count(),
                                        list.stream()
                                                .filter(cmd -> cmd.command().startsWith("show"))
                                                .count(),
                                        list.stream()
                                                .filter(cmd -> cmd.command().startsWith("shuffle"))
                                                .count(),
                                        list.stream()
                                                .filter(cmd -> cmd.command().startsWith("transfer"))
                                                .count(),
                                        list.stream()
                                                .filter(cmd -> cmd.command().startsWith("rfg"))
                                                .count(),
                                        list.stream()
                                                .filter(cmd -> cmd.command().startsWith("path"))
                                                .count(),
                                        list.stream()
                                                .filter(cmd -> cmd.command().startsWith("sect"))
                                                .count(),
                                        list.stream()
                                                .filter(cmd -> cmd.command().startsWith("clan"))
                                                .count(),
                                        list.stream()
                                                .filter(cmd -> cmd.command().startsWith("open"))
                                                .count()
                                )
                        )
                ));
    }
}
