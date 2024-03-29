//
//  ViewController.swift
//  BullsEye
//
//  Created by SGfS on 3/7/19.
//  Copyright © 2019 Sgfs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    static let MAX_SCORE = 100
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
//    @IBOutlet weak var restartBtn: UIButton!
    
    var currentValue = 0
    var targetValue = 0
    var totalScore = 0
    var round = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        restartGame()
        setupSlider()
    }

    func setupSlider() {
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func restartGame() {
        round = 0
        totalScore = 0
        startNewRound()
    }
    
    @IBAction func showAlert() {
        let difference = abs(currentValue - targetValue)
        var points = ViewController.MAX_SCORE - difference
        
        let title: String
        if difference == 0 {
            title = "Perfect!"
             points += 100
        } else if difference < 5 {
            title = "You almost had it!"
            if difference == 1 {
                points += 50
            }
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }
        
        totalScore += points
        
        let message = "You scored \(points) points."

        let alert = UIAlertController(title: title,message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: { _ in
            self.startNewRound()
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }

    @IBAction func sliderMoved(_ slider: UISlider) {
         currentValue = lroundf(slider.value)
    }

    func startNewRound() {
        round += 1
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(totalScore)
        roundLabel.text = String(round)
    }
}

