//
//  GameViewController.swift
//  yhma23.ios.groupproject
//
//  Created by Andreas Selguson on 2024-03-29.
//

import UIKit

class GameViewController: UIViewController, UITextFieldDelegate {
    
    var gameModel = GameModel()
    var countdownLabel: UILabel!
    
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
        gameModel = GameModel()
        startCountdown(from: 3)
        
        
        inputWordTextField.delegate = self
        
    }
    
    
    func startCountdown(from number: Int) {
        countdownLabel.isHidden = false // Se till att etiketten är synlig
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
            self.wordLabel.center = CGPoint(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 2)
        }, completion: { _ in
            if self.gameModel.hasMoreWords(){
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
    
    var lastPointAwardedWordIndex = -1
    
    // This function watches the text field for changes and updates the game state consequently
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Combine current text and the replacement text to get the updated text
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        // Check if updated text matches current word
        if updatedText == words[currentWordIndex - 1] && currentWordIndex != lastPointAwardedWordIndex {
            // If it matches and the current word index is different from the last one, increase the score
            let currentPoints = Int(currentPointsLabel.text ?? "0") ?? 0
            currentPointsLabel.text = String(currentPoints + 1)
            
            // Update the last word index for which a point was awarded
            lastPointAwardedWordIndex = currentWordIndex
            
            // Clear the input field for the next word
            textField.text = ""
            return false
        }
        
        return true
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
