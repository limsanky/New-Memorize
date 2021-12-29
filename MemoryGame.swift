//
//  MemoryGame.swift
//  New Memorize
//
//  Created by Sankarshana V on 2021/12/29.
//

import Foundation

struct MemoryGame<CardContent> {
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = [Card]()
        
        // add [numberOfPairsOfCards] * 2 cards to cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    // Naming is better with an empty argument label
    func choose(_ card: Card) {
        
    }
    
    // We create the Card Structure inside MemoryGame,
    // since it specifies that this structure is a part of MemoryGame!
    struct Card {
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
    }
}
