//
//  GameViewController.swift
//  Solo Mission
//
//  Created by Praveen on 23/06/2016.
//  Copyright © 2016 Praveen. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let view = self.view as! SKView? else  {
            return
        }
        
        // Load the SKScene from 'GameScene.sks'
        var size: CGSize = self.view.bounds.size
        size.width *= UIScreen.main.scale
        size.height *= UIScreen.main.scale
        let scene = GameScene(size: size)
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        
        // Present the scene
        view.presentScene(scene)
        
        view.ignoresSiblingOrder = true
        
        view.showsFPS = false
        view.showsNodeCount = false
        
    }
    
    override var shouldAutorotate: Bool {
        get {
            return true
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            if UIDevice.current.userInterfaceIdiom == .phone {
                return .allButUpsideDown
            } else {
                return .all
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }
    
}
