//
//  Cardify.swift
//  New Memorize
//
//  Created by Sankarshana V on 2022/01/01.
//

import SwiftUI

struct Cardify: ViewModifier {
    
    var isFaceUp: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            // Local variable
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            
            if isFaceUp {
                // Background
                shape.fill().foregroundColor(.white)
                
                // Edge strokes => Changed to strokeBorder() instead of stroke()
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            } else {
                // Background
                shape.fill()
            }
            
            content
                .opacity(isFaceUp ? 1 : 0)
        }
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        return self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
