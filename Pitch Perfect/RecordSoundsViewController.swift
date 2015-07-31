//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Richard smith on 7/17/15.
//  Copyright © 2015 Richard Smith. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate  {
    
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
 
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        recordingInProgress.text = "Tap to Record"
        stopButton.hidden = true
        recordButton.enabled = true
    }

    @IBAction func recordAudio(sender: UIButton) {
        recordingInProgress.text = "Recording......."
        stopButton.hidden = false
        recordButton.enabled = false
        
        
        
        //start recording 
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)[0] 
        let recordingName = "recorder1.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error:nil)
        audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:], error:nil)
        
        
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    
    
    }
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if (flag) {
        
            recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent!)
            
            
            
        self.performSegueWithIdentifier("stopTheRecording", sender: recordedAudio)
        } else {
            print("Nope")
            recordButton.enabled = true
            stopButton.enabled = true
        }
    }
        override func prepareForSegue(segue: UIStoryboardSegue, sender:AnyObject?) {
            if (segue.identifier == "stopTheRecording") {
                let playSoundsVC:playSoundsVCViewController = segue.destinationViewController as! playSoundsVCViewController
                let data = sender as! RecordedAudio
                playSoundsVC.recievedAudio = data
            }
        }
        
    
    @IBAction func stopRecording(sender: UIButton) {
        recordingInProgress.text = "Done"
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        
        audioSession.setActive(false, error:nil)
       
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

