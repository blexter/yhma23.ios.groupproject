//
//  GameModel.swift
//  yhma23.ios.groupproject
//
//  Created by Andreas Selguson on 2024-03-29.
//

import Foundation

class GameModel {
    
    // List total words must be % 3 == 0 following easy-medium-hard order
    private let words: [String] = ["Gurkan", "Båt", "Tomat", "Bil", "Penna",
                                   "Långsamt", "Fönsterputsare", "Krokodildjur", "Hemlighusnyckel", "ÖverImorgon",
                                   "MikrovågsugnsuppvÄrmninG", "SamhäLlsutvecklinGsstrategi", "ArbetsmIljöskyddsinspektör", "OlIvträdgårdsmäÄstare", "Mellanmjölksglass"
    ]
    
    private let wordsEasy: [String] = [
        "Gurka", "Tomat", "Bil", "Båt", "Matta", "Boll", "Sol", "Moln", "Katt", "Hund",
        "Röd", "Grön", "Bok", "Stol", "Fågel", "Träd", "Skor", "Hus", "Fönster", "Dörr",
        "Vatten", "Blomma", "Sten", "Sand", "Gräs", "Snö", "Regn", "Åska", "Berg", "Dal",
        "Äpple", "Banan", "Orange", "Penna", "Papper", "Bord", "Lampa", "Nyckel", "Telefon", "Sked",
        "Gaffel", "Kniv", "Tallrik", "Kopp", "Glas", "Hatt", "Jacka", "Byxor", "Tröja", "Skjorta"
    ]
    
    private var currentWordIndex = 0
    private var lastPointAwardedWordIndex = -1
    
    var selectedWords: [String] = []
    var countdownValue: Int = 0
    var countdownTimer: Timer?
    var score = 0
    
    
    func selectWords(for difficulty: Difficulty) {
        switch difficulty {
        case .easy:
            selectedWords = Array(wordsEasy.shuffled())
        case .medium:
            selectedWords = Array(words[5...9])
        case .hard:
            selectedWords = Array(words[10...14])
        }
    }

    func startWordTimer(onUpdate: @escaping (Int) -> Void, onComplete: @escaping () -> Void) {
        stopWordTimer()
        var wordTimerValue = 5
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            DispatchQueue.main.async {
                if wordTimerValue >= 0 {
                    onUpdate(wordTimerValue)
                    wordTimerValue -= 1
                } else {
                    self?.stopWordTimer()
                    onComplete()
                }
            }
        }
    }
    
    func stopWordTimer() {
        countdownTimer?.invalidate()
        countdownTimer = nil
    }
    
    
    func startCountdown(from number: Int, onUpdate: @escaping (Int) -> Void, onComplete: @escaping () -> Void) {
        countdownValue = number
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.countdownValue >= 0 {
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
}

struct Player {
    var name: String
}

enum Difficulty {
    case easy
    case medium
    case hard
}
