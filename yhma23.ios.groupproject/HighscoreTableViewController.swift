//
//  HighscoreTableViewController.swift
//  yhma23.ios.groupproject
//
//  Created by Andreas Selguson on 2024-03-29.
//

import UIKit

class HighscoreTableViewController: UITableViewController {
    var highscores: [HighscoresManager.HighscoreEntry] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        highscores = HighscoresManager.loadHighscores()
        tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return highscores.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "highScoreCell", for: indexPath)
        // Use the correctly typed highscore entry
        let score = highscores[indexPath.row]
        cell.textLabel?.text = "\(score.player): \(score.score)"
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        highscores = HighscoresManager.loadHighscores()
        tableView.reloadData()
    }

    
}

