//
//  Add1ViewController.swift
//  Solo-Games
//
//  Created by PraveenH on 23/07/20.
//  Copyright © 2020 PraveenH. All rights reserved.
//
import UIKit
import GoogleMobileAds

class Add1ViewController: UIViewController {
    
    @IBOutlet weak var numbersLabel:UILabel?
    @IBOutlet weak var scoreLabel:UILabel?
    @IBOutlet weak var inputField:UITextField?
    @IBOutlet weak var timeLabel:UILabel?
    
    var score:Int = 0
    var timer:Timer?
    var seconds:Int = 60
    var interstitial: GADInterstitial!
    //var hud:MBProgressHUD?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-9743507528822263/4728485481")
        let request = GADRequest()
        interstitial.load(request)
        setRandomNumberLabel()
        updateScoreLabel()
        updateTimeLabel()
        self.addDoneButtonOnKeyboard()
        inputField?.addTarget(self, action: #selector(textFieldDidChange(textField:)), for:UIControlEvents.editingChanged)
    }
    
    func doSomething() {
      if interstitial.isReady {
        interstitial.present(fromRootViewController: self)
      } else {
        print("Ad wasn't ready")
      }
    }
    
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        self.inputField?.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction(){
        self.inputField?.resignFirstResponder()
    }
    
    @objc func textFieldDidChange(textField:UITextField) {
        if inputField?.text?.characters.count ?? 0 < 4 {
            return
        }
        
        if  let numbers_text    = numbersLabel?.text,
            let input_text      = inputField?.text,
            let numbers         = Int(numbers_text),
            let input           = Int(input_text) {
            
            if(input - numbers == 1111) {
                print("Correct!")
                score += 1
                showHUDWithAnswer(isRight: true)
            } else {
                print("Incorrect!")
                score -= 1
                showHUDWithAnswer(isRight: false)
            }
        }
        
        setRandomNumberLabel()
        updateScoreLabel()
        
        if(timer == nil) {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector:#selector(onUpdateTimer), userInfo:nil, repeats:true)
        }
    }
    
    @objc func onUpdateTimer() {
        if(seconds > 0 && seconds <= 60) {
            seconds -= 1
            updateTimeLabel()
        } else if(seconds == 0) {
            if(timer != nil) {
                timer!.invalidate()
                timer = nil
                
                let alertController = UIAlertController(title: "Time Up!", message: "Your time is up! You got a score of: \(score) points. Very good!", preferredStyle: .alert)
                let restartAction = UIAlertAction(title: "Restart", style: .default, handler: { (alert) in
                    self.inputField?.resignFirstResponder()
                    self.doSomething()
                })
                alertController.addAction(restartAction)
                
                self.present(alertController, animated: true, completion: nil)
                //Restart
                score = 0
                seconds = 60
                
                updateTimeLabel()
                updateScoreLabel()
                setRandomNumberLabel()
                
            }
        }
    }
    
    func updateTimeLabel() {
        if(timeLabel != nil) {
            let min:Int = (seconds / 60) % 60
            let sec:Int = seconds % 60
            
            let min_p:String = String(format: "%02d", min)
            let sec_p:String = String(format: "%02d", sec)
            
            timeLabel!.text = "\(min_p):\(sec_p)"
        }
    }
    
    func showHUDWithAnswer(isRight:Bool) {
        var imageView:UIImageView?
        
        if isRight {
            imageView = UIImageView(image: UIImage(named:"thumbs-up"))
        } else {
            imageView = UIImageView(image: UIImage(named:"thumbs-down"))
        }
        
        if(imageView != nil) {
            self.inputField?.text = ""
        }
    }
    
    func updateScoreLabel() {
        scoreLabel?.text = "\(score)"
    }
    
    func setRandomNumberLabel() {
        numbersLabel?.text = generateRandomNumber()
    }
    
    func generateRandomNumber() -> String {
        var result:String = ""
        for _ in 1...4 {
            let digit:Int = Int(arc4random_uniform(8) + 1)
            result += "\(digit)"
        }
        
        return result
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
