//
//  ViewController.swift
//  bullsEye
//
//  Created by Clement Wekesa on 17/04/2018.
//  Copyright © 2018 Clement Wekesa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue = 50
    var targetValue = 0
    var score = 0
    var round = 1

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var target: UILabel!
    @IBOutlet weak var totalRound: UILabel!
    @IBOutlet weak var totalScore: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        currentValue = lroundf(slider.value)
        startNewRound()
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal") // UIImage(named: "SliderThumb-Nomal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted") // UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let inserts = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft") // UIImage(named: "SliderTrackLeft")
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight") // UIImage(named: "SliderTrackRight")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: inserts)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: inserts)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }
    
    func startNewRound() {
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
        target.text = "\(targetValue)"
        totalScore.text = "\(score)"
        totalRound.text = "\(round)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startNewGame() {
        score = 0
        round = 1
        startNewRound()
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value)
    }
    
    @IBAction func showAlert() {
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        
        let title: String
        if difference == 0 {
            points += 100
            title = "Perfect!"
        } else if difference < 5 {
            points += 50
            title = "Yu almost had it!"
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "not even close..."
        }
        
        round += 1
        score += points
        
        let alert = UIAlertController(title: "\(title)", message: "The value of slider is now: \(currentValue)" + "\nYou've scored: \(points)", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Awesome", style: .default, handler: { action in
            self.startNewRound()
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}

