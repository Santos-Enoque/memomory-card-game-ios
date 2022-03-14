//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Santos Enoque on 10/03/22.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    static let emojis = ["❤️", "🤲🏻", "🍑", "💧", "🔥", "🏦", "✅", "☺️", "💙", "🚰", "👍", "🛑", "💲", "🌐"]
    
    static private func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 10 ) { index in emojis[index]}
    }
    @Published private var model = createMemoryGame()
    
    var cards: [Card] {
        model.cards
    }
    
    // MARK: - Intents
    func choose (_ card: Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func restart() {
        model = EmojiMemoryGame.createMemoryGame()
    }
    
}
