//
//  DifficultyModes.swift
//  yhma23.ios.groupproject
//
//  Created by A.S on 2024-04-01.
//

import UIKit



class DifficultyModes: UIViewController {
    
    var gameModel = GameModel()
    
    @IBAction func easyMode(_ sender: UIButton) {
        startGame(withDifficulty: .easy)
    }
    
    @IBAction func mediumMode(_ sender: Any) {
        startGame(withDifficulty: .medium)
    }
    
    @IBAction func hardMode(_ sender: Any) {
        startGame(withDifficulty: .hard)
    }
    
    func startGame(withDifficulty difficulty: Difficulty) {
        gameModel.selectWords(for: difficulty)
        performSegue(withIdentifier: "startGame", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startGame", let gameViewController = segue.destination as? GameViewController {
            gameViewController.words = gameModel.selectedWords
        }
    }
}

