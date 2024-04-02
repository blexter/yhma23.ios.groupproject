//
//  GameModel.swift
//  yhma23.ios.groupproject
//
//  Created by Andreas Selguson on 2024-03-29.
//

import Foundation

class GameModel {
    
    private let words: [String] = ["easy1", "easy2", "easy3", "easy4", "easy5", "medium1", "medium2", "medium3", "medium4", "medium5", "hard1", "hard2", "hard3", "hard4", "hard5"]
    
    var selectedWords: [String] = []
    
    func selectWords(for difficulty: Difficulty) {
        // logic for choosing words based on difficulty
        switch difficulty {
        case .easy:
            selectedWords = Array(words[0...4])
        case .medium:
            selectedWords = Array(words[5...9])
        case .hard:
            selectedWords = Array(words[10...14])
            break
        }
    }
    
}

struct Word {
    var text : String
    var isCompleted : Bool = false
}

struct Points {
    var correctWords : Int = 0
    var incorrectWords : Int = 0
    var playerName : String
}

enum Difficulty {
    case easy
    case medium
    case hard
}
