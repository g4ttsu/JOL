package net.deckserver.game.validators;

import net.deckserver.game.enums.CardType;
import net.deckserver.services.CardService;
import net.deckserver.storage.json.game.CardData;

import java.util.List;

public class OncePerGameValidator {

    private static final List<String> cards;

    static {
        cards = List.of(
                //Once a Game
                "100064",
                "101417",
                "101591",
                "100775",
                "101036",
                "102132",
                "100723",
                "100743",
                "100793",
                "100824",
                "100853",
                "100870",
                "101133",
                "101324",
                "101607",
                "101619",
                "101880",
                "101927",
                "102166",
                "101561",
                "101335",
                "101029",
                "101955",
                "102099",
                //Out of Turn
                "100012",
                "100067",
                "100085",
                "100141",
                "100261",
                "100419",
                "100493",
                "100543",
                "100545",
                "100606",
                "100636",
                "100676",
                "100791",
                "100805",
                "100883",
                "101078",
                "101084",
                "101095",
                "101103",
                "101145",
                "101183",
                "101219",
                "101303",
                "101369",
                "101504",
                "101580",
                "101584",
                "101654",
                "101841",
                "101890",
                "101896",
                "102052",
                "102132",
                "102147",
                "102151",
                "102198"
        );
    }

    public static boolean validate(CardData card) {
       if(cards.contains(card.getCardId()))
           return true;
       if(card.getType().equals(CardType.EVENT))
           return true;
       return false;
    }
}
