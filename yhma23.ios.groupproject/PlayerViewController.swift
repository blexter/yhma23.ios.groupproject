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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        playerNameLabel.text = player.name
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
