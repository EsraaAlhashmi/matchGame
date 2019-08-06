//
//  cardModel.swift
//  matchGame
//
//  Created by Esraa Alhashemi on 16/07/2019.
//  Copyright © 2019 Esraa Alhashemi. All rights reserved.
//

import Foundation

class cardModel{
    
    
    func getCards() -> [Card]{
        
        var numbers = [Int]()
        //declare an array to store the cards
        var cardArray = [Card]()
        //randomely genratoe cards (8 pairs)
        while numbers.count < 8 {
            
            let randomNum = arc4random_uniform(13) + 1
            
            if !numbers.contains(Int(randomNum)) {
                
                //store the number
                numbers.append(Int(randomNum))
                
                let cardOne = Card()
                cardOne.imageName = "card\(randomNum)"
                cardArray.append(cardOne)
                
                let cardTwo = Card()
                cardTwo.imageName = "card\(randomNum)"
                cardArray.append(cardTwo)
                
            }
            
        }
        //randomize the array
        for i in 0...cardArray.count-1 {
            
            let random = Int(arc4random_uniform(UInt32(cardArray.count)))
            
            let temp = cardArray[i]
            cardArray[i] = cardArray[random]
            cardArray[random] = temp
        }
        
        //return the array
        return cardArray
    }
}

