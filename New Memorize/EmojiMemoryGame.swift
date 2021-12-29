//
//  EmojiMemoryGame.swift
//  New Memorize
//
//  Created by Sankarshana V on 2021/12/29.
//

import SwiftUI


class EmojiMemoryGame {
    // We make the two following properties [static], because they are required for any instance of EmojiMemoryGame!
    static let emojis = ["🚂", "✈️", "🚗", "🚓", "🚡", "🚚", "🚎", "🚑", "⛵️",
                  "🚇", "🛵", "🛬", "🛫", "🛺", "🛰"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in
            EmojiMemoryGame.emojis[pairIndex]
        }
    }
    
    // The model is set to [private],
    // because the ViewModel should be the only thing which can see the model.
    private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()

    
    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }
}
