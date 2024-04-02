//
//  GameModel.swift
//  yhma23.ios.groupproject
//
//  Created by Andreas Selguson on 2024-03-29.
//

import Foundation

class GameModel {
    
    private let words: [String] = ["easy1", "easy2", "easy3", "easy4", "easy5", "medium1", "medium2", "medium3", "medium4", "medium5", "hard1", "hard2", "hard3", "hard4", "hard5"]
    private var currentWordIndex = 0
    private var lastPointAwardedWordIndex = -1
    
    var selectedWords: [String] = []
    var countdownValue: Int = 0
    var countdownTimer: Timer?
    var score = 0
    
    
    func selectWords(for difficulty: Difficulty) {
        switch difficulty {
        case .easy:
            selectedWords = Array(words[0...4])
        case .medium:
            selectedWords = Array(words[5...9])
        case .hard:
            selectedWords = Array(words[10...14])
        }
    }

    
    func startCountdown(from number: Int, onUpdate: @escaping (Int) -> Void, onComplete: @escaping () -> Void) {
        countdownValue = number
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.countdownValue > 0 {
                onUpdate(self.countdownValue)
                self.countdownValue -= 1
            } else {
                self.countdownTimer?.invalidate()
                self.countdownTimer = nil
                onComplete()
            }
        }
    }
    
    func getNextWord() -> String? {
        guard currentWordIndex < selectedWords.count else { return nil }
        let word = selectedWords[currentWordIndex]
        currentWordIndex += 1
        return word
    }
    
    func hasMoreWords() -> Bool {
        return currentWordIndex < selectedWords.count
    }
    
    func checkAndUpdateScore(with input: String) -> Bool {
            guard currentWordIndex < selectedWords.count, currentWordIndex != lastPointAwardedWordIndex else { return false }
            
            if input == selectedWords[currentWordIndex - 1] {
                score += 1
                lastPointAwardedWordIndex = currentWordIndex
                return true
            }
            return false
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
