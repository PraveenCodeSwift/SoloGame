//
//  GameViewController.swift
//  Stick-Hero
//
//  Created by Praveen on 15/6/19.
//  Copyright (c) 2015 Praveen. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

class StickHiroGameViewController: UIViewController {
   
    var musicPlayer:AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let scene = StickHeroGameScene(size:CGSize(width: DefinedScreenWidth, height: DefinedScreenHeight))
        
        let skView = self.view as! SKView

        skView.ignoresSiblingOrder = true
        
        scene.scaleMode = .aspectFill
        scene.vc = self
        
        skView.presentScene(scene)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        musicPlayer = setupAudioPlayerWithFile("stick_grow_loop", type: "mp3")
//        musicPlayer.numberOfLoops = -1
    }

    func setupAudioPlayerWithFile(_ file:NSString, type:NSString) -> AVAudioPlayer  {
        let url = Bundle.main.url(forResource: file as String, withExtension: type as String)
        var audioPlayer:AVAudioPlayer?
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: url!)
        } catch {
            print("NO AUDIO PLAYER")
        }
        
        return audioPlayer!
    }
    
    override var shouldAutorotate : Bool {
        return true
    }

    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .portrait
    }

    override var prefersStatusBarHidden : Bool {
        return true
    }
}
