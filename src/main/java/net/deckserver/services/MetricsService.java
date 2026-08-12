package net.deckserver.services;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.io.UncheckedIOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.OffsetDateTime;
import java.time.ZoneOffset;
import java.util.ArrayList;
import java.util.List;

public class MetricsService {

    private static final Logger logger = LoggerFactory.getLogger(MetricsService.class);

    public List<PlayerMetricsDto> load() {
        logger.info("Loading Metrics from File System");
        List<PlayerMetricsDto> players = new ArrayList<>();
        Path root = Paths.get("C:\\DEV\\g4ttsu\\JOL\\src\\test\\resources\\data\\metrics"); //TODO change to correct path on tomcat for METRICS

        try {
            players.addAll(Files.walk(root)
                    .filter(Files::isRegularFile)
                    .filter(path -> path.toString().endsWith(".log"))
                    .flatMap(path -> readCsv(path).stream())
                    .toList());
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        return players;

    }

    public List<PlayerMetricsDto> readCsv(Path file) {
        try {
            return Files.readAllLines(file).stream()
                    .map(String::trim)
                    .filter(line -> !line.isEmpty())
                    .map(line -> {
                        String[] values = line.split(",");

                        int year = Integer.parseInt(values[0]);
                        int month = Integer.parseInt(values[1]);
                        int day = Integer.parseInt(values[2]);
                        int hour = Integer.parseInt(values[3]);

                        OffsetDateTime timestamp = OffsetDateTime.of(
                                year,
                                month,
                                day,
                                hour,
                                0,
                                0,
                                0,
                                ZoneOffset.UTC
                        );

                        return new PlayerMetricsDto(
                                timestamp,
                                values[4].replace("\"", ""),
                                values[5].replace("\"", ""),
                                Boolean.parseBoolean(values[6].replace("\"", "")),
                                Boolean.parseBoolean(values[7].replace("\"", ""))
                        );
                    })
                    .toList();

        } catch (IOException e) {
            throw new UncheckedIOException(e);
        }
    }

    public record PlayerMetricsDto (OffsetDateTime timestamp, String playerName, String gameName, boolean didCommand, boolean didChat) {}
}
