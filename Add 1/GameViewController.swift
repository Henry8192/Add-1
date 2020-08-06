//
//  ViewController.swift
//  Add 1
//
//  Created by Henry on 8/3/20.
//  Copyright © 2020 Lowiro. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateScoreLabel()
        updateNumberLabel()
        updateTimeLabel()

    }
    
    var score = 0
    var timer:Timer?
    var seconds = 60
    
    func updateScoreLabel() {
        scoreLabel?.text = String(score)
    }
    func updateNumberLabel() {
        numberLabel?.text = String.randomNumber(length: 4)
    }
    func updateTimeLabel() {

        let min = seconds / 60
        let sec = seconds % 60

        timeLabel?.text = String(format: "%02d", min) + ":" + String(format: "%02d", sec)
    }
    func finishGame() {
        timer?.invalidate()
        timer = nil
        let alert = UIAlertController(title: "Time's Up!", message: "Your time is up! You got a score of \(score) points. Awesome!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK, start new game", style: .default, handler: nil))

        self.present(alert, animated: true, completion: nil)
        
        score = 0
        seconds = 60
        updateTimeLabel()
        updateScoreLabel()
        updateNumberLabel()
    }
    
    
    
    
    @IBAction func inputFieldDidChange() {
        guard let numberText = numberLabel?.text, let inputText = inputField?.text
        else {return}
        
        if inputText.count != 4 {return}
        var isCorrect = 1
        for n in 0..<4 {
            var input = inputText.integer(at: n)
            let number = numberText.integer(at: n)
            
            if input != (number + 1)%10 {
                isCorrect = 0
                break
            }
        }
        score += isCorrect

        updateNumberLabel()
        updateScoreLabel()
        inputField?.text = ""
        
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                if self.seconds == 0 {
                    self.finishGame()
                }
                else if self.seconds <= 60 {
                    self.seconds -= 1
                    self.updateTimeLabel()
                }
            }
        }
    }
   
//    timer func
    
    
    
    @IBOutlet weak var scoreLabel:UILabel?
    @IBOutlet weak var timeLabel:UILabel?
    @IBOutlet weak var numberLabel:UILabel?
    @IBOutlet weak var inputField:UITextField?
    
    


}

