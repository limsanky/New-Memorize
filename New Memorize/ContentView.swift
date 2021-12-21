//
//  ContentView.swift
//  New Memorize
//
//  Created by Sankarshana V on 2021/12/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // The [alignment] parameter is defaulted to be the center
        // Since the [content] parameter is the 'last' parameter, it can be outside of the rounded brackets, and instead be in the curly braces.
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 3)
            
            Text("Hello, world!")
        }
        .padding(.horizontal)   // Adds padding only to the ZStack!
        .foregroundColor(.red)  // Sets the default colour of the ZStack as Red
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
