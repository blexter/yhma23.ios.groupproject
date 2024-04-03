//
//  EndViewController.swift
//  yhma23.ios.groupproject
//
//  Created by Andreas Selguson on 2024-03-29.
//

import UIKit

class EndViewController: UIViewController {

    @IBOutlet weak var totalPointsLabel: UILabel!
    
    @IBAction func playAgainButton(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func highscoreButton(_ sender: Any) {
    }
    
    var totalPoints: Int = 0 {
        didSet {
            updatePointsDisplay()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        updatePointsDisplay()

        // Do any additional setup after loading the view.
    }
    
    func updatePointsDisplay() {
        if isViewLoaded {
            DispatchQueue.main.async {
                self.totalPointsLabel.text = "Total Points: \(self.totalPoints)"
            }
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

}
