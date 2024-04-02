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
        if let gameViewController = storyboard?.instantiateViewController(withIdentifier: "gameViewController") as? GameViewController {
            gameViewController.gameModel = gameModel
            navigationController?.pushViewController(gameViewController, animated: true)
        }
    }

}

