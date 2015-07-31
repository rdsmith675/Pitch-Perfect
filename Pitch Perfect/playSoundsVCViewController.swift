//
//  playSoundsVCViewController.swift
//  Pitch Perfect
//
//  Created by Richard smith on 7/21/15.
//  Copyright © 2015 Richard Smith. All rights reserved.
//

import UIKit
import AVFoundation

class playSoundsVCViewController: UIViewController, AVAudioPlayerDelegate {

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
        
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.rate = 0.5
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
        
    }
    
    @IBAction func fastPlayButton(sender: UIButton) {
        
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.rate = 2.0
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
        
        
    }
    
    @IBAction func playChipmunkSound(sender: UIButton) {
    
            playAudioWithVariablePitch(1000)
        
    }

    @IBAction func darthVaderSound(sender: UIButton) {
        
        playAudioWithVariablePitch(-1000)
    }
    @IBAction func stopButton(sender: UIButton) {
        
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
    }
    
    
    
    
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
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
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
