//
//  GameModel.swift
//  yhma23.ios.groupproject
//
//  Created by Andreas Selguson on 2024-03-29.
//

import Foundation

class GameModel {
    
}

struct word {
    var text : String
    var isCompleted : Bool = false
}

struct points {
    var correctWords : Int = 0
    var incorrectWords : Int = 0
    var playerName : String
}
