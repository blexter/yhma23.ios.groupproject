//
//  GameViewController.swift
//  yhma23.ios.groupproject
//
//  Created by Andreas Selguson on 2024-03-29.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var currentPointsLabel: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var writeTheWordLabel: UILabel!
    @IBOutlet weak var inputWordTextField: UITextField!

    var words: [String] = ["Hello", "World", "App", "iOS", "Game","Android"]
    var currentWordIndex = 0
    
    @IBAction func okButton(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let countdownLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        countdownLabel.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 2)
        countdownLabel.textAlignment = .center
        countdownLabel.font = UIFont.boldSystemFont(ofSize: 48) 
        countdownLabel.textColor = UIColor.blue 
        view.addSubview(countdownLabel)

        startCountdown(from: 3, label: countdownLabel)
    }


    func startCountdown(from number: Int, label: UILabel) {
        if number > 0 {
            // Update label
            label.text = "\(number)"

            // Repeat function after a delay 1 second in between
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.startCountdown(from: number - 1, label: label)
            }
        } else {

            // Hide the countdown label and start animation
            label.isHidden = true

            startFallingAnimation()
        }
    }

     func startFallingAnimation() {

        // Reset the wordLabel position
        wordLabel.center = CGPoint(x: view.frame.size.width / 2, y: -wordLabel.frame.size.height / 2)

        // Set the next word
        wordLabel.text = words[currentWordIndex]
        currentWordIndex = (currentWordIndex + 1) % words.count

        // Start the animation
        UIView.animate(withDuration: 5.0, animations: {
            // Move the wordLabel down in the screen
            self.wordLabel.center = CGPoint(x: self.view.frame.size.width / 2, y: self.view.frame.size.height + self.wordLabel.frame.size.height / 2)
        }, completion: { _ in
            // When animation completes, start it again with the next word
            self.startFallingAnimation()
        })
     }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
