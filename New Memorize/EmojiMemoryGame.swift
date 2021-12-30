//
//  EmojiMemoryGame.swift
//  New Memorize
//
//  Created by Sankarshana V on 2021/12/29.
//

import SwiftUI


class EmojiMemoryGame: ObservableObject {
    // We make the two following properties [static], because they are required for any instance of EmojiMemoryGame!
    private static let emojis = ["🚂", "✈️", "🚗", "🚓", "🚡", "🚚", "🚎", "🚑", "⛵️",
                  "🚇", "🛵", "🛬", "🛫", "🛺", "🛰"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 3) { pairIndex in
            EmojiMemoryGame.emojis[pairIndex]
        }
    }
    
    // The model is set to [private],
    // because the ViewModel should be the only thing which can see the model.
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()

    
    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }
    
    // MARK: Intent(s)
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
