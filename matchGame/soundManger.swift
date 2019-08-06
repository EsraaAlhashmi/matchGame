//
//  soundManger.swift
//  matchGame
//
//  Created by Esraa Alhashemi on 16/07/2019.
//  Copyright © 2019 Esraa Alhashemi. All rights reserved.
//

import Foundation
import AVFoundation

class SoundManger {
    
    static var audioPlayer:AVAudioPlayer?
    
    enum soundEffect {
        
        case flip
        case shuffle
        case match
        case nomatch
    }
    
    static func playSound(_ effect:soundEffect) {
        
        var soundFileName = ""
        
        switch effect {
            
            case .flip:
                soundFileName = "cardflip"
            
            case .shuffle:
                soundFileName = "shuffle"
            
            case .match:
                soundFileName = "dingcorrect"
            
            case .nomatch:
                soundFileName = "dingwrong"
        
        }
        
        let bundlePath = Bundle.main.path(forResource: soundFileName, ofType: "wav")
        
        guard bundlePath != nil else {
            print("couldn't find sound file name")
            return
        }
        
        //create URL object
        let soundURL = URL(fileURLWithPath: bundlePath!)
        
        //create audio player object
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.play()
        }
        catch{
            print("couldn't find sound file URL")
            //return
        }
    }
    
}
