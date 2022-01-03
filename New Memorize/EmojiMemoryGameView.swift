//
//  EmojiMemoryGameView.swift
//  New Memorize
//
//  Created by Sankarshana V on 2021/12/21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    @Namespace private var dealingNamespace
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                gameBody
                HStack {
                    restart
                    Spacer()
                    shuffle
                }
            }
            deckBody
        }
        .padding()
    }
    
    private func zIndex(of card: EmojiMemoryGame.Card) -> Double {
        -Double(game.cards.firstIndex(where: { $0.id == card.id }) ?? 0)
    }
    
    private func dealAnimation(for card: EmojiMemoryGame.Card) -> Animation {
        var delay = 0.0
        
        if let index = game.cards.firstIndex(where: { $0.id == card.id }) {
            delay = Double (index) * (CardConstants.totalDealDuration / Double(game.cards.count))
        }
        
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(game.cards.filter(isUndealt)) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
                    .zIndex(zIndex(of: card))
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
        .foregroundColor(CardConstants.color)

        .onTapGesture {
            // "deal" cards
            for card in game.cards {
                withAnimation (dealAnimation(for: card)) {
                    deal(card)
                }
            }
        }
    }
    
    @State private var dealt = Set<Int>()
    
    private func deal(_ card: EmojiMemoryGame.Card) {
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: EmojiMemoryGame.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    private var gameBody: some View {
        AspectVGrid (items: game.cards, aspectRatio: 2/3) { cardView(for: $0) }
        .foregroundColor(CardConstants.color)
    }
    
    @ViewBuilder
    private func cardView(for card: EmojiMemoryGame.Card) -> some View {
        if isUndealt(card) || (card.isMatched && !card.isFaceUp) {
//            Rectangle().opacity(0)
            Color.clear
        } else {
            CardView(card: card)
                .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                .padding(4)
                .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                .zIndex(zIndex(of: card))
                .onTapGesture {
                    withAnimation (.easeInOut) {
                        game.choose(card)
                    }
                }
        }
    }
    
    private var shuffle: some View {
        Button("Shuffle") {
            // IMPORTANT: We generally use explicit animations with intents!!
            withAnimation {
                game.shuffle()
            }
        }
    }
    
    private var restart: some View {
        Button("Restart") {
            withAnimation {
                dealt = []
                game.restart()
            }
        }
    }
    
    private struct CardConstants {
        static let color = Color.red
        static let aspectRatio: CGFloat = 2/3
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 2.0
        static let undealtHeight: CGFloat = 90
        static let undealtWidth = undealtHeight * aspectRatio
    }
}

// Creating a new CardView as a struct instead
struct CardView: View {
    let card: EmojiMemoryGame.Card
    
    @State private var animatedBonusRemaining: Double = 0
   
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Group {
                    // Adding a Pie Shape in the middle
                    if (card.isConsumingBonusTime) {
                        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: (1-animatedBonusRemaining)*360 - 90))
                            .onAppear {
                                animatedBonusRemaining = card.bonusRemaining
                                withAnimation(.linear(duration: card.bonusTimeRemaining)) {
                                    animatedBonusRemaining = 0
                                }
                            }
                    } else {
                        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: (1-card.bonusRemaining)*360 - 90))
                    }
                }
                .padding(5)
                .opacity(DrawingConstants.circleOpacity)
                
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: card.isMatched)
                    .font(Font.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    // MARK: Control Panel
    private func font(in size: CGSize) -> Font{
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) * DrawingConstants.fontScale / DrawingConstants.fontSize
    }
    
    private struct DrawingConstants {
        static let fontScale: CGFloat = 0.7
        static let circleOpacity: Double = 0.5
        static let fontSize: CGFloat = 32
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
.previewInterfaceOrientation(.portrait)
//        EmojiMemoryGameView(game: game)
//            .preferredColorScheme(.dark)
    }
}
