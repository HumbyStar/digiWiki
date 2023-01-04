//
//  EpisodesViewController.swift
//  DigiWIki
//
//  Created by Humberto Rodrigues on 14/12/22.
//

import UIKit

class EpisodesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var episodes: [Episode] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        //loadJson()
    }
    
    func getEpisodeIndex (index: Int) {
        let episode = episodes[index]
        performSegue(withIdentifier: "epiSegue", sender: episode)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AssistirViewController
        vc.episode = sender as? Episode
    }
    
    @IBAction func Close(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

extension EpisodesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let episode = episodes[indexPath.row]
        
        cell.textLabel?.text = episode.episodio
        cell.detailTextLabel?.text = episode.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        getEpisodeIndex(index: index)
    }
}
