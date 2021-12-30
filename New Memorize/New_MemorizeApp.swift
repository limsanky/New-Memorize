//
//  New_MemorizeApp.swift
//  New Memorize
//
//  Created by Sankarshana V on 2021/12/21.
//

import SwiftUI

@main
struct New_MemorizeApp: App {
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
