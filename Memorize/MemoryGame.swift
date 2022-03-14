//
//  MemoryGame.swift
//  Memorize
//
//  Created by Santos Enoque on 10/03/22.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    
    private var indexOfTheOneAndOnlyFacedUpCard: Int? {
        get { cards.indices.filter{cards[$0].isFacedUp}.oneAndOnly }
        set { cards.indices.forEach{cards[$0].isFacedUp = ($0 == newValue)} }
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(id: pairIndex * 2, content: content))
            cards.append(Card(id: pairIndex * 2 + 1,content: content))
        }
        
        cards.shuffle()
    }
    
    mutating func choose(_ card: Card) {
        if let choosenIndex = cards.firstIndex(where: {$0.id == card.id }) ,!cards[choosenIndex].isFacedUp
            ,!cards[choosenIndex].isMatched {
          
            if let potentialIndex = indexOfTheOneAndOnlyFacedUpCard {
                if cards[potentialIndex].content == cards[choosenIndex].content {
                    cards[choosenIndex].isMatched = true
                    cards[potentialIndex].isMatched = true
                }
                cards[choosenIndex].isFacedUp = true
               
            } else {
                indexOfTheOneAndOnlyFacedUpCard = choosenIndex
            }
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    

    struct Card: Identifiable {
        let id: Int
        var isFacedUp = false
        var isMatched = false
        let content: CardContent
    }
}

extension Array {
    var oneAndOnly: Element? {
        if count == 1 {
            return first
        } else {
            return nil
        }
    }
}
