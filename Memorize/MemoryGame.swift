//
//  MemoryGame.swift
//  Memorize
//
//  Created by Santos Enoque on 10/03/22.
//

import Foundation

struct MemoryGame<CardContent> {
    private(set) var cards: [Card]
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    func choose(_ card: Card) {
        
    }
    
    struct Card  {
        var isFacedUp = false
        var isMatched = false
        var content: CardContent
    }
}
