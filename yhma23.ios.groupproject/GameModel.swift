//
//  GameModel.swift
//  yhma23.ios.groupproject
//
//  Created by Andreas Selguson on 2024-03-29.
//

import Foundation

class GameModel {
    
    private let wordsEasy: [String] = [
        "Katt", "Hund", "Hus", "Bok", "Penna", "Äpple", "Bil", "Träd", "Sol", "Måne",
        "Stol", "Bord", "Skor", "Klocka", "Dörr", "Fönster", "Vägg", "Golv", "Tak", "Lampa",
        "Blomma", "Gräs", "Regn", "Snö", "Is", "Matta", "Säng", "Kudde", "Tallrik", "Gaffel",
        "Kniv", "Sked", "Glas", "Bokhylla", "Spegel", "Boll", "Dator", "Mobil", "Nyckel", "Leksak",
        "Fågel", "Fisk", "Groda", "Björn", "Elefant", "Giraff", "Lejon", "Tiger", "Zebra", "Ko"
    ]
    
    private let wordsMedium: [String] = [
        "Kamel", "Känguru", "Flodhäst", "Noshörning", "Krokodil", "Alligator", "Igelkott", "Skunk", "Tvättbjörn", "Panda",
        "Orkan", "Ciklon", "Tsunami", "Jordskalv", "Vulkan", "Meteorit", "Asteroid", "Kompass", "Teleskop", "Mikroskop",
        "Katalysator", "Fotosyntes", "Evaporation", "Kondensation", "Sublimation", "Destillation", "Erosion", "Sedimentering", "Oxidation", "Reduktion",
        "Polär", "Ekvator", "Meridian", "Longitud", "Latitud", "Biosfär", "Stratosfär", "Troposfär", "Mesosfär", "Termosfär",
        "Biografi", "Autobiografi", "Manuskript", "Monolog", "Dialog", "Prolog", "Epilog", "Synopsis", "Antologi", "Bibliografi"
    ]
    
    private let wordsHard: [String] = [
        "Quasar", "Nebulosa", "Supernova", "Hypernova", "Svart hål", "Vit dvärg", "Neutronstjärna", "Pulsar", "Gammastrålning", "Röd jätte",
        "Kvantmekanik", "Relativitetsteorin", "Supersträngteori", "Higgs boson", "Mörk materia", "Mörk energi", "Entropi", "Singularity", "Plancks konstant", "Heisenbergs osäkerhetsprincip",
        "Kryptoanalys", "Steganografi", "Kryptografi", "Blockchain", "Asymmetrisk kryptering", "Symmetrisk kryptering", "Hashfunktion", "Digital signatur", "Public key", "Private key",
        "Epistemologi", "Ontologi", "Metafysik", "Deontologi", "Utilitarism", "Existentialism", "Fenomenologi", "Hermeneutik", "Postmodernism", "Strukturalism",
        "Palindrom", "Anagram", "Akronym", "Homonym", "Synonym", "Antonym", "Eufemism", "Onomatopoei", "Alliteration", "Assonans"
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
            selectedWords = Array(wordsMedium.shuffled())
        case .hard:
            selectedWords = Array(wordsHard.shuffled())
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
