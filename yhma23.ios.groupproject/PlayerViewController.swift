//
//  PlayerViewController.swift
//  yhma23.ios.groupproject
//
//  Created by Linus Ilbratt on 2024-04-02.
//

import UIKit

class PlayerViewController: UIViewController {

    @IBOutlet weak var playerNameLabel: UILabel!
    
    var player = Player(name: "Default Player")
    
    
    @IBAction func changeButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "Change Player Name", message: "Enter a new player name", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "New player name"
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        let change = UIAlertAction(title: "Change", style: .default) { [weak self, weak alert] _ in
            guard let alertController = alert, let textField = alertController.textFields?.first else { return }
            
            let newName = textField.text ?? "Default Player"
            UserDefaults.standard.set(newName, forKey: "PlayerName")
            
            self?.player.name = newName
            self?.playerNameLabel.text = newName
        }
        
        alert.addAction(cancel)
        alert.addAction(change)
        
        present(alert, animated: true)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        let savedName = UserDefaults.standard.string(forKey: "PlayerName") ?? "Default Player"
            player.name = savedName
            playerNameLabel.text = savedName
    }
    
    
    
}
