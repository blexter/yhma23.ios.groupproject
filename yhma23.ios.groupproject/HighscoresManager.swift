
import Foundation

class HighscoresManager {
    
    struct HighscoreEntry: Codable {
        var player: String
        var score: Int
    }

    private static let highscoresKey = "highscores"
    
    static func saveHighscore(_ highscore: HighscoreEntry) {
        var highscores = loadHighscores()
        highscores.append(highscore)
        highscores.sort { $0.score > $1.score }
        if let encoded = try? JSONEncoder().encode(highscores) {
            UserDefaults.standard.set(encoded, forKey: highscoresKey)
        }
    }
    
    static func loadHighscores() -> [HighscoreEntry] {
        if let savedScores = UserDefaults.standard.object(forKey: highscoresKey) as? Data {
            if let decodedScores = try? JSONDecoder().decode([HighscoreEntry].self, from: savedScores) {
                return decodedScores
            }
        }
        return []
    }
}

