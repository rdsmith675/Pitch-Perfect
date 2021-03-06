//
//  PlaySoundsVCViewController.swift
//  Pitch Perfect
//
//  Created by Richard smith on 7/21/15.
//  Copyright © 2015 Richard Smith. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsVCViewController: UIViewController, AVAudioPlayerDelegate {

    var audioPlayer:AVAudioPlayer!
    var recievedAudio:RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        audioPlayer = AVAudioPlayer(contentsOfURL: recievedAudio.filePathUrl, error:nil)
        audioFile = AVAudioFile(forReading: recievedAudio.filePathUrl, error:nil)
        
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func slowPlayButton(sender: UIButton) {
        

        
            playAudioWithVariableRate(0.5)
    
    }
    
    @IBAction func fastPlayButton(sender: UIButton) {
      
        
            playAudioWithVariableRate(2.0)
        
        
    }
    
    @IBAction func playChipmunkSound(sender: UIButton) {
        
        
            playAudioWithVariablePitch(1000)
        
    }

    @IBAction func darthVaderSound(sender: UIButton) {
    
        playAudioWithVariablePitch(-1000)
    }
    @IBAction func stopButton(sender: UIButton) {
        
      resetAudio()
        
    }
    
    
    
    
    func playAudioWithVariablePitch(pitch: Float){
        
        resetAudio()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        
           audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    
    func resetAudio() {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    func playAudioWithVariableRate(rate: Float) {
        resetAudio()
        
        audioPlayer.currentTime = 0.0
        var changeAudioRate = audioPlayer
        changeAudioRate.rate = rate
        audioPlayer.play()
    
    
    }
    
    
    
    
    
    
    
    
    
    
   
}
