//
//  FlipCard.swift
//  FlipCard
//
//  Created by Nishant Hooda on 2017-12-23.
//  Copyright © 2017 Nishant Hooda. All rights reserved.
//

import Foundation

class Concentration{
    
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int?{
        get {
            return cards.indices.filter {cards[$0].isFaceup}.oneAndOnly
            /*            var foundIndex: Int?
             for index in cards.indices {
             if cards[index].isFaceup {
             if foundIndex == nil{
             foundIndex = index
             }else {
             return nil
             }
             }
             }
             return foundIndex*/
        }
        set {
            for index in cards.indices{
                cards[index].isFaceup = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int){
        assert(cards.indices.contains(index), "Chosen index: \(index) not in the cards")
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                if cards[matchIndex] == cards[index]{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceup = true
            }
            else{
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPariedCards: Int){
        assert(numberOfPariedCards > 0, "Must have at least one pair of cards")
        for number in 0...numberOfPariedCards{
            let card = Card(indentifier: number)
            cards += [card, card]
        }
    }
}

extension Collection {
    var oneAndOnly: Element?  {
        return count == 1 ? first:nil
    }
}

