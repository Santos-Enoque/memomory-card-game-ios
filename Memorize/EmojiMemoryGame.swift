//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Santos Enoque on 10/03/22.
//

import SwiftUI

class EmojiMemoryGame {
    static let emojis = ["❤️", "🤲🏻", "🍑", "💧", "🔥", "🏦", "✅", "☺️", "💙", "🚰", "👍", "🛑", "💲", "🌐"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4 ) { index in emojis[index]}
    }
    private var model = createMemoryGame()
    
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }
    
}
