//
//  ResultViewController.swift
//  DigiWIki
//
//  Created by Humberto Rodrigues on 11/12/22.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var lbScore: UILabel!
    
    var score: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        lbScore.text = "\(score)"
    }
    
    @IBAction func Close(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
