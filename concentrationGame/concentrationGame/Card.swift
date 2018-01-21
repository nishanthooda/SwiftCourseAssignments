//
//  Card.swift
//  FlipCard
//
//  Created by Nishant Hooda on 2017-12-23.
//  Copyright © 2017 Nishant Hooda. All rights reserved.
//

import Foundation

struct Card: Hashable{
    var hashValue: Int {return indentifier}
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.indentifier == rhs.indentifier
    }
    
    var isFaceup = false
    var isMatched = false
    private var indentifier: Int
    
    init(indentifier: Int){
        self.indentifier = indentifier
    }
    
    private static var indentifierFactory = 0
    
    private static func getUniqueIndentifier () -> Int{
        indentifierFactory += 1
        return indentifierFactory
    }
}

