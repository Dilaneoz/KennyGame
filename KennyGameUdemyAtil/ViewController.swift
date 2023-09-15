//
//  ViewController.swift
//  KennyGameUdemyAtil
//
//  Created by Dilan Öztürk on 8.03.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    
    var timer = Timer()
    var counter = 0
    var score = 0
    var highscore = 0
    
    var kennyArray = [UIImageView]()
    
    var moveKenny = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        counter = 10
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(time), userInfo: nil, repeats: true)
        
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            
            highscore = 0
            highScoreLabel.text = "Highscore : \(highscore)"
        }
        if let newScore = storedHighScore as? Int {
            
            highscore = newScore
            highScoreLabel.text = "Highscore : \(highscore)"
        }
        
        
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(changeScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(changeScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(changeScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(changeScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(changeScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(changeScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(changeScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(changeScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(changeScore))

        kenny1.addGestureRecognizer(recognizer1)
        kenny2.addGestureRecognizer(recognizer2)
        kenny3.addGestureRecognizer(recognizer3)
        kenny4.addGestureRecognizer(recognizer4)
        kenny5.addGestureRecognizer(recognizer5)
        kenny6.addGestureRecognizer(recognizer6)
        kenny7.addGestureRecognizer(recognizer7)
        kenny8.addGestureRecognizer(recognizer8)
        kenny9.addGestureRecognizer(recognizer9)

        kennyArray = [kenny1, kenny2, kenny3, kenny4, kenny5, kenny6, kenny7, kenny8, kenny9]
        
        hidden()
        
        moveKenny = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hidden), userInfo: nil, repeats: true) // belli bir zaman aralığında random bi kenny göster
    }
    
    
    @objc func changeScore () {
        
        score += 1
        scoreLabel.text = "Score : \(score)"
    }
    
    
    @objc func hidden () {
        
        for kenny in kennyArray {
            
            kenny.isHidden = true
        }

        let random = Int(arc4random_uniform(UInt32(kennyArray.count - 1))) // random bi kenny seç
        
        kennyArray[random].isHidden = false // seçilen kenny i gizleme
    }


    @objc func time () {
        
        timerLabel.text = "\(counter)"
        counter -= 1

        if counter < 0 {
            
            timer.invalidate()
            moveKenny.invalidate()
            
            if self.score > self.highscore {
                
                self.highscore = self.score
                highScoreLabel.text = "Highscore : \(self.highscore)"
                UserDefaults.standard.set(self.highscore, forKey: "highscore")
                
            }
            
            let alert = UIAlertController(title: "Time's Up!", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { [self] UIAlertAction in // replay e basınca tekrar oynat
                
                score = 0
                changeScore()
                counter = 10
                timerLabel.text = "\(counter)"
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(time), userInfo: nil, repeats: true)
                moveKenny = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hidden), userInfo: nil, repeats: true)
                
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true)
            
            for kenny in kennyArray {
                
                kenny.isHidden = true
            }
        }
    }
}

