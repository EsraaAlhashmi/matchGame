//
//  CardCollectionViewCell.swift
//  matchGame
//
//  Created by Esraa Alhashemi on 16/07/2019.
//  Copyright © 2019 Esraa Alhashemi. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var front: UIImageView!
    @IBOutlet weak var back: UIImageView!
    
    
    var card:Card?
    
    func setCard(_ card:Card) {
        
        self.card = card
        
        if card.matchesd{
            back.alpha=0
            front.alpha=0
            
            return
        }
        else{
            back.alpha=1
            front.alpha=1
        }
        
        front.image = UIImage(named: card.imageName)
        
        if card.isFlipped{
            UIView.transition(from: back, to: front, duration: 0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        }
        else{
            UIView.transition(from: front, to: back, duration: 0, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        }
    }
    
    func flip() {
        
        UIView.transition(from: back, to: front, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        
    }
    
    func flipBack() {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5){
            UIView.transition(from: self.front, to: self.back, duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        }
        
       
        
    }
    
    func remove(){
        
        back.alpha = 0
        
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            self.front.alpha = 0
        }, completion: nil)
    }
    
}
