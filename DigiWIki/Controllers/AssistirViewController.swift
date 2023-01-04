//
//  AssistirViewController.swift
//  DigiWIki
//
//  Created by Humberto Rodrigues on 14/12/22.
//

import UIKit
import AVKit

class AssistirViewController: UIViewController {
    
    @IBOutlet weak var viEpisode: UIView!
    @IBOutlet weak var lbWitchDigimon: UILabel!
    @IBOutlet weak var lbInfo: UILabel!
    
    var episode: Episode!
    var player: AVPlayer!
    var playerViewController: AVPlayerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formatView()
        formatEpisode()
    }
    
    func formatView() {
        lbInfo.text = "\(episode.episodio)  \(episode.title)"
        lbWitchDigimon.text = episode.name
    }
    
    func formatEpisode() {
        let url = URL(string: episode.URL)!
        player = AVPlayer(url: url)
        playerViewController = AVPlayerViewController()
        playerViewController.player = player
        playerViewController.showsPlaybackControls = true
        playerViewController.player?.play()
        
        playerViewController.view.frame = viEpisode.bounds
        viEpisode.addSubview(playerViewController.view)
    }
    
}
