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
        var playerName: String {
            return UserDefaults.standard.string(forKey: "PlayerName") ?? "Unknown Player"
        }
        let finalScore = gameModel.score
        let highscoreEntry = HighscoresManager.HighscoreEntry(player: playerName, score: finalScore)
        HighscoresManager.saveHighscore(highscoreEntry)

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
        
        wordLabel.alpha = 0
        startCountdown(from: 3)
        
        inputWordTextField.delegate = self
        inputWordTextField.isEnabled = false

        
    }
    
    
    func startCountdown(from number: Int) {
        countdownLabel.center = CGPoint(x: view.frame.size.width / 2, y: (view.frame.size.height / 2) - 150)
        countdownLabel.isHidden = false
        
        gameModel.startCountdown(from: number, onUpdate: { [weak self] remainingTime in
            DispatchQueue.main.async {
                self?.countdownLabel.text = "\(remainingTime)"
            }
        }, onComplete: { [weak self] in
            DispatchQueue.main.async {
                self?.countdownLabel.isHidden = true
                self?.fadeInWord()
                self?.inputWordTextField.isEnabled = true
                self?.inputWordTextField.becomeFirstResponder()
            }
        })
    }
    
    func fadeInWord() {
        if gameModel.selectedWords.isEmpty {
            displayGameFinishMessage()
            return
        }
        
        guard let nextWord = gameModel.getNextWord() else {
            wordLabel.isHidden = true
            displayGameFinishMessage()
            return
        }
        
        wordLabel.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 2)
        wordLabel.text = nextWord
        wordLabel.alpha = 0
        
        UIView.animate(withDuration: 1.0) {
            self.wordLabel.alpha = 1
        }
        
        startWordTimer()
    }



    func startWordTimer() {
        var wordTimerValue = 5
        countdownLabel.isHidden = false
        countdownLabel.text = "\(wordTimerValue)"

        _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            DispatchQueue.main.async {
                wordTimerValue -= 1
                self?.countdownLabel.text = "\(wordTimerValue)"

                if wordTimerValue == 0 {
                    UIView.animate(withDuration: 1.0) {
                        self?.wordLabel.alpha = 0
                    }
                }

                if wordTimerValue < 0 {
                    timer.invalidate()
                    self?.countdownLabel.isHidden = true
    
                    if self?.gameModel.hasMoreWords() == true {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self?.fadeInWord()
                        }
                    } else {
                        self?.displayGameFinishMessage()
                    }
                }
            }
        }
    }





    
    
    func displayGameFinishMessage() {
        // New label for the game finish message
        let gameFinishLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        
        gameFinishLabel.center = CGPoint(x: view.frame.size.width / 2, y: (view.frame.size.height / 2) - 150)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "endViewSegue", let destinationVC = segue.destination as? EndViewController {
            destinationVC.totalPoints = self.gameModel.score
        }
    }

    
    
}
