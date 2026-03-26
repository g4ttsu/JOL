package net.deckserver.storage.json.deck;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.Set;

@Getter
@NoArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
public class DeckStats {

    private int cryptSize;
    private int librarySize;
    private Set<String> groups;
    private boolean bannedCards;
    private String summary;
    private Set<String> clans;
    private Set<String> discs;

    public DeckStats(int cryptSize, int librarySize, Set<String> groups, boolean hasBannedCards, Set<String> clans, Set<String> discs) {
        this.cryptSize = cryptSize;
        this.librarySize = librarySize;
        this.groups = groups;
        this.bannedCards = hasBannedCards;
        this.clans = clans;
        this.discs = discs;
        this.summary = String.format("Crypt: %d Library: %d Groups: %s", cryptSize, librarySize, String.join("/", groups));
    }

}
