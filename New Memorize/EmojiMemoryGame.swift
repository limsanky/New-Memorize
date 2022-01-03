//
//  EmojiMemoryGame.swift
//  New Memorize
//
//  Created by Sankarshana V on 2021/12/29.
//

import SwiftUI


class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    // We make the two following properties [static], because they are required for any instance of EmojiMemoryGame!
    private static let emojis = ["🚂", "✈️", "🚗", "🚓", "🚡", "🚚", "🚎", "🚑", "⛵️",
                  "🚇", "🛵", "🛬", "🛫", "🛺", "🛰"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 6) { pairIndex in
            EmojiMemoryGame.emojis[pairIndex]
        }
    }
    
    // The model is set to [private],
    // because the ViewModel should be the only thing which can see the model.
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()

    var cards: [Card] {
        return model.cards
    }
    
    // MARK: Intent(s)
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func restart() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}
