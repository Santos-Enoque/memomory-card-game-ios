//
//  MemoryGame.swift
//  Memorize
//
//  Created by Santos Enoque on 10/03/22.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    
    private var indexOfTheOneAndOnlyFacedUpCard: Int?
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(id: pairIndex * 2, content: content))
            cards.append(Card(id: pairIndex * 2 + 1,content: content))
        }
    }
    
    mutating func choose(_ card: Card) {
        if let choosenIndex = cards.firstIndex(where: {$0.id == card.id }) ,!cards[choosenIndex].isFacedUp
            ,!cards[choosenIndex].isMatched {
            if let potentialIndex = indexOfTheOneAndOnlyFacedUpCard {
                if cards[potentialIndex].content == cards[choosenIndex].content {
                    cards[choosenIndex].isMatched = true
                    cards[potentialIndex].isMatched = true
                }
                indexOfTheOneAndOnlyFacedUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFacedUp = false
                }
                indexOfTheOneAndOnlyFacedUpCard = choosenIndex
            }
            cards[choosenIndex].isFacedUp.toggle()
        }
    }
    

    struct Card: Identifiable {
        var id: Int
        var isFacedUp = false
        var isMatched = false
        var content: CardContent
    }
}
