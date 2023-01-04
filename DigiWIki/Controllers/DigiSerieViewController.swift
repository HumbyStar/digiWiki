//
//  DigiSerieViewController.swift
//  DigiWIki
//
//  Created by Humberto Rodrigues on 01/12/22.
//

import UIKit

class DigiSerieViewController: UIViewController {
    @IBOutlet weak var ivBanner: UIImageView!
    @IBOutlet weak var lbEpisodes: UILabel!
    @IBOutlet weak var lbYear: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    
    
    var digiInfo: Info?
    var index: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        ivBanner.image = UIImage(named: digiInfo?.name ?? "")
        lbEpisodes.text = "Episódios: \(digiInfo?.episodes ?? 0)"
        lbYear.text = "Data de Lançamento: \(digiInfo?.year ?? "")"
        lbDescription.text = "Descrição: \(digiInfo?.description ?? "")"
        lbTitle.text = digiInfo?.name ?? ""
        
    }
    
    @IBAction func ChoosedDigimonSerie(_ sender: UIButton) {
        if let episodes = digiInfo?.watchEpisodes {
            performSegue(withIdentifier: "choosedSegue", sender: episodes)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! EpisodesViewController
        vc.episodes = sender as! [Episode]
    }
    
    // Tenho que criar uma funcao que passe esse indice
}



