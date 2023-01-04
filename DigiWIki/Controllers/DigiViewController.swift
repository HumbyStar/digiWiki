//
//  DigiViewController.swift
//  DigiWIki
//
//  Created by Humberto Rodrigues on 11/12/22.
//

import UIKit

class DigiViewController: UIViewController {
    @IBOutlet weak var lbDigimon: UILabel!
    @IBOutlet weak var ivDigimon: UIImageView!
    @IBOutlet weak var lbAge: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    
    var digimonAbout: Digimon!

    override func viewDidLoad() {
        super.viewDidLoad()
        lbDigimon.text = digimonAbout.name
        if let image = digimonAbout.firstIMG as? UIImage {
            ivDigimon.image = image
        }
        lbAge.text = "Age: \(digimonAbout.age ?? "")"
        lbDescription.text = "Descrição: \(digimonAbout.descript ?? "")"
        
    }
    

    
}
