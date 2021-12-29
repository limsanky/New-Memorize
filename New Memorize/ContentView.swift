//
//  ContentView.swift
//  New Memorize
//
//  Created by Sankarshana V on 2021/12/21.
//

import SwiftUI

struct ContentView: View {
    // Creating an Array
    // Can be done:
    //  1. Array<String>
    //  2. [String]
    var emojis = ["🚂", "✈️", "🚗", "🚓", "🚡", "🚚", "🚎", "🚑", "⛵️",
                  "🚇", "🛵", "🛬", "🛫", "🛺", "🛰"]
    @State var emojiCount = 14
    let veg = "red pepper"

    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(emojis[0..<emojiCount], id: \.self, content: { emoji in
                        CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                    })
                }
            }
            .foregroundColor(.red)
        }
        .padding(.horizontal)
    }
}

// Creating a new CardView as a struct instead
struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true
   
    var body: some View {
        
        ZStack {
            // Local variable
            let shape = RoundedRectangle(cornerRadius: 20)
            
            if isFaceUp {

                // Background
                shape.fill().foregroundColor(.white)
                
                // Edge strokes => Changed to strokeBorder() instead of stroke()
                shape.strokeBorder(lineWidth: 3)
                
                Text(content).font(.largeTitle)
            } else {
                // Background
                shape.fill().foregroundColor(.red)
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
.previewInterfaceOrientation(.portrait)
    }
}
