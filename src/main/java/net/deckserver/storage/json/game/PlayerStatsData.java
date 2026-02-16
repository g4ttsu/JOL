package net.deckserver.storage.json.game;

import lombok.Data;

@Data
public class PlayerStatsData {
    private final String playerName;
    private final long allGames;
    private final double vp;
    private final int gw;
}
