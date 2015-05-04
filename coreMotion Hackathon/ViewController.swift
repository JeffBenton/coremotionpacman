//
//  ViewController.swift
//  coreMotion Hackathon
//
//  Created by Jeff on 5/4/15.
//  Copyright (c) 2015 Jeff. All rights reserved.
//

import UIKit
import CoreMotion
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var currentlyPlaying: UILabel!
    var playing = false

    let motion: CMMotionManager = CMMotionManager()
     var waka = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("PacmanWakaWaka", ofType: "mp3")!)
    var audioWaka = AVAudioPlayer()
    var opening = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("PacmanOpeningSong", ofType: "mp3")!)
    var audioOpening = AVAudioPlayer()
    var closing = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("PacmanDies", ofType: "mp3")!)
    var audioClosing = AVAudioPlayer()
    var eating = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("PacmanEatingGhost", ofType: "mp3")!)
    var audioEating = AVAudioPlayer()

    
    @IBAction func startButton(sender: UIButton) {
        if !playing {
            audioOpening.play()
            self.currentlyPlaying.text = "Herro"
            motion.accelerometerUpdateInterval = 0.1
            
            motion.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue(), withHandler: { (accelerometerData: CMAccelerometerData!, error: NSError!) -> Void in self.outputAcclerationData(accelerometerData.acceleration)
                if error != nil {
                    println("\(error)")
                }
            })
            playing = true
        }
    }

    @IBAction func stopButton(sender: UIButton) {
        if playing {
            audioClosing.play()
            self.currentlyPlaying.text = "Play again"
            motion.stopAccelerometerUpdates()
            playing = false
        }
    }
    
    override func viewDidLoad() {
        audioWaka = AVAudioPlayer(contentsOfURL: waka, error: nil)
        audioWaka.prepareToPlay()
        audioOpening = AVAudioPlayer(contentsOfURL: opening, error: nil)
        audioOpening.prepareToPlay()
        audioClosing = AVAudioPlayer(contentsOfURL: closing, error: nil)
        audioClosing.prepareToPlay()
        audioEating = AVAudioPlayer(contentsOfURL: eating, error: nil)
        audioEating.prepareToPlay()
        super.viewDidLoad()
    }

    
    func outputAcclerationData(acceleration: CMAcceleration) {
        if acceleration.x > 2 || acceleration.x < -2 {
            audioWaka.play()
            self.currentlyPlaying.text = "Waka waka"
        }
        if acceleration.y > 2 || acceleration.y < -2 {
            audioWaka.play()
            self.currentlyPlaying.text = "Waka waka"
        }
        if acceleration.z > 2 || acceleration.z < -2 {
            audioEating.play()
            self.currentlyPlaying.text = "Eating a ghost"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

