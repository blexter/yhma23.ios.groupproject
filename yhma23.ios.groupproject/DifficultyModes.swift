//
//  DifficultyModes.swift
//  yhma23.ios.groupproject
//
//  Created by A.S on 2024-04-01.
//

import UIKit



class DifficultyModes: UIViewController {
    
    let words: [String] = ["easy1", "easy2", "easy3", "easy4", "easy5", "medium1", "medium2", "medium3", "medium4", "medium5", "hard1", "hard2", "hard3", "hard4", "hard5"]
    var selectedWords: [String] = []

    @IBAction func easyMode(_ sender: UIButton) {
        startGame(withWords: Array(words[0...4]))
    }
    
    @IBAction func mediumMode(_ sender: Any) {
        startGame(withWords: Array(words[5...9]))
    }
    
    @IBAction func hardMode(_ sender: Any) {
        startGame(withWords: Array(words[10...14]))
    }
    
    func startGame(withWords words: [String]) {
        // Store the selected words in a property
        selectedWords = words

        // Perform the segue
        performSegue(withIdentifier: "startGame", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startGame" {
            if let gameViewController = segue.destination as? GameViewController {
                gameViewController.words = selectedWords
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


    

    
    




/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */


