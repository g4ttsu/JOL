package net.deckserver.storage.json.game;

import lombok.Data;

import java.time.OffsetDateTime;

@Data
public class PlayerStat {
    private final String gameName;
    private final OffsetDateTime startTime;
    private final OffsetDateTime endTime;
    private final String deckName;
    private final String playerName;
    private final boolean gameWin;
    private final double vp;
}
