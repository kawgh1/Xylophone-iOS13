//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 28/06/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer?
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func keyPressed(_ sender: UIButton) {
        
        playSound(soundName: sender.currentTitle!)
        dimBackgroundColor(key: sender)
        // delay 0.3 seconds after click
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
           // Code to be delayed
            self.restoreBackgroundColor(key:sender)
        }
        
    }
    
    func playSound(soundName: String){
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "wav") else {return}
                
                do{
                    // setting Category ".playback" means the sound will play even if the phone is on silent
                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                    try AVAudioSession.sharedInstance().setActive(true)
                    
//                 this line is required for the player to work on iOS 11
                    player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
                    
//                   iOS 10 and earlier require the following line:
//                   player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3)
                    guard let player = player else {return}
                    
                    player.play()
                } catch let error {
                    print(error.localizedDescription)
                }
    }
    
    func dimBackgroundColor(key: UIButton) {
        key.layer.opacity = 0.5
    }
    
    func restoreBackgroundColor(key: UIButton) {
        key.layer.opacity = 1
    }
    
//      Course Code
//    func playSound() {
//        let url = Bundle.main.url(forResource: "C", withExtension: "wav")
//        player = try! AVAudioPlayer(contentsOf: url!)
//        player.play()
//
//    }
    

}

