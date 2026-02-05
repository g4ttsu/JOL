package net.deckserver.storage.json.game;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class PlayedCard {
    String cardId;
    String cardName;
    String playerName;
    String turnNumber;

    public PlayedCard(){}

    public PlayedCard(String cardId, String cardName, String playerName, String turnNumber) {
        this.cardId = cardId;
        this.cardName = cardName;
        this.playerName = playerName;
        this.turnNumber = turnNumber;
    }
}
