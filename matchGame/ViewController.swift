//
//  ViewController.swift
//  matchGame
//
//  Created by Esraa Alhashemi on 16/07/2019.
//  Copyright © 2019 Esraa Alhashemi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    var model = cardModel()
    var myCardArray = [Card]()
    
    @IBOutlet weak var timer: UILabel!
    var time:Timer?
    var millSecond:Float = 30*1000
    
    var firstFlippedCardIndex:IndexPath? //if its nil then its the first card
    
   // var soundmanger = SoundManger()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myCardArray =  model.getCards()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        time = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerElepsed), userInfo: nil, repeats: true)
        RunLoop.main.add(time!, forMode: .common)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        SoundManger.playSound(.shuffle)
        
    }
    
    @objc func timerElepsed(){
        
        millSecond-=1
        
        //convert to seconds
        let seonnds = String(format: "%.2f", millSecond/1000)
        
        timer.text = "Time Remaining: \(seonnds)"
        
        //reaching zero
        if millSecond <= 0 {
            
            time?.invalidate()
            timer.textColor = UIColor.red
            
            checkEndGame()
        }
    }
    
    func checkEndGame(){
        
        var isWon = true
        
        for card in myCardArray{
            
            if !card.matchesd{
                isWon = false
                break
            }
        }
        
        var title = ""
        var message = ""
        
        if isWon{
            
            if millSecond > 0{
                time?.invalidate()
            }
            
            title = "Congraugulations!"
            message = "You've won"
            
        }
        else{
            
            if millSecond > 0{
                return
            }
            
            title = "GameOver!"
            message = "You've lost"
            
        }
        
        //alerting
        showAlert(title, message)
        
       /*
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
 */
        
    }
    
    func showAlert(_ title:String, _ message:String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return myCardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! CardCollectionViewCell
        
        cell.setCard(myCardArray[indexPath.row])
        
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if millSecond <= 0{
            return
        }
        
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        let card = myCardArray[indexPath.row]
        
        
        if !card.isFlipped && !card.matchesd{
            cell.flip()
            SoundManger.playSound(.flip)
            card.isFlipped = true
            
            //is it the first ?
            if firstFlippedCardIndex == nil{
                firstFlippedCardIndex = indexPath
            }
            else{
                checkMatches(indexPath)
            }
        }//end first if
        
       
        
        
    }//end did select

    func checkMatches(_ secondFlippedCardIndex:IndexPath){
        
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        
        
        let cardOne = myCardArray[firstFlippedCardIndex!.row]
        let cardTwo = myCardArray[secondFlippedCardIndex.row]
        
        //campare
        
        if cardOne.imageName == cardTwo.imageName{
            
            SoundManger.playSound(.match)
            
            cardOne.matchesd = true
            cardTwo.matchesd = true
            
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
            checkEndGame()
            
        }
        else{
            
            SoundManger.playSound(.nomatch)
            
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
            
            
        }
        
        if cardOneCell == nil{
            collectionView.reloadItems(at: [firstFlippedCardIndex!])
        }
        
        firstFlippedCardIndex = nil
        
    }
    
}//end class



