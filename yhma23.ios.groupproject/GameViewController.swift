//
//  GameViewController.swift
//  yhma23.ios.groupproject
//
//  Created by Andreas Selguson on 2024-03-29.
//

import UIKit

class GameViewController: UIViewController, UITextFieldDelegate {
    
    var countdownLabel: UILabel!
    var gameModel = GameModel()
    
    @IBOutlet weak var currentPointsLabel: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var writeTheWordLabel: UILabel!
    @IBOutlet weak var inputWordTextField: UITextField!
    
    var currentWordIndex = 0
    var words: [String] = []
    
    @IBAction func okButton(_ sender: Any) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        countdownLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        countdownLabel.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 2)
        countdownLabel.textAlignment = .center
        countdownLabel.font = UIFont.boldSystemFont(ofSize: 48)
        countdownLabel.textColor = UIColor.blue
        view.addSubview(countdownLabel)
        
        // setting up gamemodel object and starting the countdown method
        
        startCountdown(from: 3)
        
        inputWordTextField.delegate = self
        
    }
    
    
    func startCountdown(from number: Int) {
        countdownLabel.isHidden = false
        gameModel.startCountdown(from: number, onUpdate: { [weak self] remainingTime in
            DispatchQueue.main.async {
                self?.countdownLabel.text = "\(remainingTime)"
            }
        }, onComplete: { [weak self] in
            DispatchQueue.main.async {
                self?.countdownLabel.isHidden = true
                self?.startFallingAnimation() // Starta animationen när nedräkningen är klar
            }
        })
    }
    
    func startFallingAnimation() {
        // check to see if there is any words chosen
        if gameModel.selectedWords.isEmpty {
            displayGameFinishMessage()
            return
        }
        
        guard let nextWord = gameModel.getNextWord() else {
            wordLabel.isHidden = true
            displayGameFinishMessage()
            return
        }
        
        // position label for animation
        wordLabel.center = CGPoint(x: view.frame.size.width / 2, y: -wordLabel.frame.size.height / 2)
        wordLabel.text = nextWord
        
        // start the animation
        UIView.animate(withDuration: 4.0, animations: {
            self.wordLabel.center = CGPoint(x: self.view.frame.size.width / 2, y: self.view.frame.size.height + self.wordLabel.frame.size.height / 2)
        }, completion: { _ in
            if self.gameModel.hasMoreWords() {
                self.startFallingAnimation()
            } else {
                self.wordLabel.isHidden = true
                self.displayGameFinishMessage()
            }
        })
    }
    
    
    
    func displayGameFinishMessage() {
        // New label for the game finish message
        let gameFinishLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        gameFinishLabel.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 2)
        gameFinishLabel.textAlignment = .center
        gameFinishLabel.font = UIFont.boldSystemFont(ofSize: 22)
        gameFinishLabel.textColor = UIColor.red
        gameFinishLabel.text = "Game finish"
        
        // Delay to display the game finish message
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.view.addSubview(gameFinishLabel)
            
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        // call GameModel to control that it updates the text and decide if a point should be added
        if gameModel.checkAndUpdateScore(with: updatedText) {
            // update UI based on users input
            currentPointsLabel.text = String(gameModel.score)
            
            // clear textfield for next word
            textField.text = ""
            return false
        }
        
        return true
    }
    
}
