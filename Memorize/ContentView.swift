//
//  ContentView.swift
//  Memorize
//
//  Created by Santos Enoque on 10/03/22.
//

import SwiftUI

struct ContentView: View {
    var emojis = ["❤️", "🤲🏻", "🍑", "💧", "🔥", "🏦", "✅", "☺️", "💙", "🚰", "👍", "🛑", "💲", "🌐"]
    @State private var emojiCount = 6
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid (columns: [GridItem(.adaptive(minimum: 69))]) {
                    ForEach(emojis, id: \.self) {emoji in
                        CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)                }
                    
                }.foregroundColor(.red)
            }
            Spacer()
        
        }.padding(.horizontal)
    }
    
}

struct CardView: View {
    var content: String
    @State private var isFacedUp: Bool = true
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 25)
            if isFacedUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }.onTapGesture {
            isFacedUp.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //        ContentView()
        //            .preferredColorScheme(.dark)
        ContentView()
        
    }
}
