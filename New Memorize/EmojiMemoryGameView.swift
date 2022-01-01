//
//  EmojiMemoryGameView.swift
//  New Memorize
//
//  Created by Sankarshana V on 2021/12/21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        AspectVGrid (items: game.cards, aspectRatio: 2/3) { cardView(for: $0) }
        .foregroundColor(.red)
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func cardView(for card: EmojiMemoryGame.Card) -> some View {
        if card.isMatched && !card.isFaceUp {
            Rectangle().opacity(0)
        } else {
            CardView(card: card)
                .padding(4)
                .onTapGesture {
                    game.choose(card)
                }
        }
    }
}

// Creating a new CardView as a struct instead
struct CardView: View {
    let card: EmojiMemoryGame.Card
   
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Local variable
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                
                if card.isFaceUp {

                    // Background
                    shape.fill().foregroundColor(.white)
                    
                    // Edge strokes => Changed to strokeBorder() instead of stroke()
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    
                    // Adding a Pie Shape in the middle
                    Pie(startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: 110 - 90))
                        .padding(5)
                        .opacity(DrawingConstants.circleOpacity)
                    
                    Text(card.content)
                        .font(font(in: geometry.size))
                } else if card.isMatched {
                    // This makes the card invisible once they are matched.
                    shape.opacity(0)
                } else {
                    // Background
                    shape.fill().foregroundColor(.red)
                }
            }
        }

    }
    
    // MARK: Control Panel
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.7
        static let circleOpacity: Double = 0.5
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
//        EmojiMemoryGameView(game: game)
//            .preferredColorScheme(.dark)
    }
}
