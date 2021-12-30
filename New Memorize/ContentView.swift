//
//  ContentView.swift
//  New Memorize
//
//  Created by Sankarshana V on 2021/12/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                ForEach(viewModel.cards) { card in
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
        }
        .foregroundColor(.red)
        .padding(.horizontal)
    }
}

// Creating a new CardView as a struct instead
struct CardView: View {
    let card: MemoryGame<String>.Card
   
    var body: some View {
        
        ZStack {
            // Local variable
            let shape = RoundedRectangle(cornerRadius: 20)
            
            if card.isFaceUp {

                // Background
                shape.fill().foregroundColor(.white)
                
                // Edge strokes => Changed to strokeBorder() instead of stroke()
                shape.strokeBorder(lineWidth: 3)
                
                Text(card.content).font(.largeTitle)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        
        ContentView(viewModel: game)
.preferredColorScheme(.light)
        ContentView(viewModel: game)
.preferredColorScheme(.dark)
    }
}
