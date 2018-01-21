//
//  ViewController.swift
//  FlipCard
//
//  Created by Nishant Hooda on 2017-12-23.
//  Copyright © 2017 Nishant Hooda. All rights reserved.
//

import UIKit

class FlipCardViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPariedCards: (cardButtons.count+1)/2)
    
    private(set) var flipCount = 0{
        didSet{
            updateFlipCountLabel()
        }
    }
    
    private func updateFlipCountLabel(){
        let attributes: [NSAttributedStringKey: Any] = [
            .strokeWidth : 5.0,
            .strokeColor : UIColor.blue
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!{
        didSet{
            updateFlipCountLabel()
        }
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let CardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: CardNumber)
            UpdateViewFromModel()
        }
        else {
            print("card chosen not in array")
        }
    }
    
    private func UpdateViewFromModel() {
        if cardButtons != nil{
            for index in cardButtons.indices{
                let button = cardButtons[index]
                let card = game.cards[index]
                if card.isFaceup{
                    button.setTitle(emoji (for: card), for:UIControlState.normal)
                    button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                }
                else{
                    button.setTitle("", for: UIControlState.normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
                }
            }
        }
    }
    
    private func flipCard (withEmoji emoji: String, on button: UIButton){
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        }
        else {
            button.setTitle(emoji, for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    
    var theme: String? {
        didSet{
            emojiChoices = theme ?? ""
            emoji = [:]
            UpdateViewFromModel()
        }
    }
    //private var emojiChoices = ["🐶", "🎃", "👻", "🐼", "🦒","🐓", "❤️","🦋","🏳️","🚑 "]
    private var emojiChoices = "🐶🎃👻🐼🦒🐓❤️🦋🏳️🚑"
    
    private var emoji = Dictionary<Card, String>()
    
    /* private func emoji (for card: Card) -> String {
     if emoji[card] == nil, emojiChoices.count > 0{
     emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
     }
     
     return emoji[card] ?? "?"
     }
     }*/
    
    private func emoji (for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0{
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
}

extension Int {
    var arc4random: Int{
        if self > 0{
            return Int(arc4random_uniform(UInt32(self)))
        }
        else if self < 0{
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }
        else{
            return 0
        }
    }
}


