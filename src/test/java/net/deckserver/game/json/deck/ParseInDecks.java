package net.deckserver.game.json.deck;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.databind.type.MapType;
import com.fasterxml.jackson.databind.type.TypeFactory;
import com.google.common.collect.HashBasedTable;
import com.google.common.collect.Table;
import net.deckserver.storage.json.deck.ExtendedDeck;
import net.deckserver.storage.json.system.DeckInfo;
import net.deckserver.storage.json.system.GameHistory;
import net.deckserver.storage.json.system.PlayerResult;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.filefilter.DirectoryFileFilter;
import org.apache.commons.io.filefilter.RegexFileFilter;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.time.OffsetDateTime;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.stream.Collectors;

public class ParseInDecks {

    static ObjectMapper mapper = new ObjectMapper();
    TypeFactory typeFactory = mapper.getTypeFactory();

    static {
        mapper.findAndRegisterModules();
        mapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);
        mapper.enable(SerializationFeature.INDENT_OUTPUT);
    }

    @Test
    public void test() throws IOException {

        List<ExtendedDeck> pastDecks = readInDecks();
        List<PlayerResult> pastGames = readInPastGames(true);
        Table<String, String, DeckInfo> decksJson = readInDeckJson();

        Table<String, String, DeckInfo> deckPlayers = HashBasedTable.create();
        for (PlayerResult playerResult : pastGames) {
            ExtendedDeck extendedDeck = pastDecks.stream().filter(deckName -> deckName.getDeck().getName().equals(playerResult.getDeckName()))
                    .findFirst().orElse(null);
            if (extendedDeck != null) {
                deckPlayers.put(playerResult.getPlayerName(), extendedDeck.getDeck().getName(), new DeckInfo(extendedDeck.getDeck().getId(), extendedDeck.getDeck().getName(), null, null));
            }
        }


        decksJson.putAll(deckPlayers);
        mapper.writeValue(new File("C:\\Users\\extprenn\\Downloads\\deckstuff\\newDecksNoDup.json"), decksJson);
    }

    public List<ExtendedDeck> readInDecks() {
        Collection files = FileUtils.listFiles(
                new File("C:\\Users\\extprenn\\Downloads\\deckstuff\\Deck"),
                new RegexFileFilter("^(.*?)"),
                DirectoryFileFilter.DIRECTORY);
        List<ExtendedDeck> allDecks = new ArrayList<>();
        for (Object file : files) {
            try {
                ExtendedDeck deck = mapper.readValue((File) file, ExtendedDeck.class);
                deck.getDeck().setId(((File) file).getName().split(".json")[0]);
                if (deck.getDeck().getName() != null || !deck.getDeck().getName().equals("")) {
                    allDecks.add(deck);
                }
            } catch (Exception e) {
            }
        }
        return allDecks;
    }

    public List<PlayerResult> readInPastGames(boolean removeDuplicates) throws IOException {
        TypeFactory typeFactory = mapper.getTypeFactory();
        Map<OffsetDateTime, GameHistory> loaded = mapper
                .readValue(new File("C:\\Users\\extprenn\\Downloads\\deckstuff\\pastGames.json"), typeFactory.constructMapType(ConcurrentHashMap.class, OffsetDateTime.class, GameHistory.class));
        List<PlayerResult> playerResults = loaded.values().stream().map(GameHistory::getResults).collect(Collectors.toList()).
                stream()
                .flatMap(List::stream)
                .collect(Collectors.toList());


        if (removeDuplicates) {
            List<PlayerResult> playerResultsNoDup = new ArrayList<>();
            for (PlayerResult playerResult : playerResults) {
                if(playerResults.stream().anyMatch(result ->
                        result.getDeckName().equals(playerResult.getDeckName()) && !result.getPlayerName().equals(playerResult.getPlayerName()))) {

                } else {
                    playerResultsNoDup.add(playerResult);
                }
            }
            return playerResultsNoDup;
        }
        return playerResults;
    }

    protected Table<String, String, DeckInfo> readInDeckJson() throws IOException {
        Table<String, String, DeckInfo> decks = HashBasedTable.create();
        MapType deckMapType = typeFactory.constructMapType(Map.class, String.class, DeckInfo.class);
        Map<String, Map<String, DeckInfo>> decksMapFile = mapper.readValue(new File("C:\\Users\\extprenn\\Downloads\\deckstuff\\decks.json"), typeFactory.constructMapType(ConcurrentHashMap.class, typeFactory.constructType(String.class), deckMapType));
        decksMapFile.forEach((playerName, decksMap) -> {
            decksMap.forEach((deckName, deckInfo) -> decks.put(playerName, deckName, deckInfo));
        });
        return decks;
    }
}
