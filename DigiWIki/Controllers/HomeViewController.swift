//
//  ViewController.swift
//  DigiWIki
//
//  Created by Humberto Rodrigues on 29/11/22.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView2: UITableView!
    @IBOutlet weak var cvPaggers: UICollectionView!
    
    var digimonSeries: DigiSeries? // CONTEM INFO DAS SERIES DE DIGIMON JA FEITAS
    var digiAbout: Digimon!
    var fetchedResultController: NSFetchedResultsController<Digimon>!
    
    func loadJson() { // CARREGAR O JSON CRIADO
        if let path = Bundle.main.path(forResource: "digi", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let jsonResult = try JSONSerialization.jsonObject(with: data)
                let jsonData = try JSONSerialization.data(withJSONObject: jsonResult)
                let jsonDecoder = JSONDecoder()
                digimonSeries = try jsonDecoder.decode(DigiSeries.self, from: jsonData)
            } catch {
                print (error)
            }
        }
    }
    
    func loadDigimons () { //MARK: CARREGAR OS DIGIMONS DE CoreData
        let fetchRequest: NSFetchRequest<Digimon> = Digimon.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        //MARK: Requisição ao banco de dados feita
        
        fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self
        
        do {
            try fetchedResultController.performFetch()
        } catch {
            print (error)
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadJson()
        loadDigimons()
        cvPaggers.delegate = self
        cvPaggers.dataSource = self
        tableView2.delegate = self
        tableView2.dataSource = self
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "digimonSegue" {
            let vc = segue.destination as! DigiViewController
            if let digiAbout = fetchedResultController.fetchedObjects {
                vc.digimonAbout = digiAbout[tableView2.indexPathForSelectedRow!.row]
            }
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = digimonSeries?.DigimonSeries.count ?? 0
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as! BannerCollectionViewCell
        
        let digiInfo = digimonSeries?.DigimonSeries[indexPath.row]
        cell.prepare(with: digiInfo!)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let digiSVC = storyboard?.instantiateViewController(withIdentifier: "DigiSerie") as! DigiSerieViewController
        if let info = digimonSeries?.DigimonSeries[indexPath.row] {
            digiSVC.digiInfo = info
        }
        let index = indexPath.row
            digiSVC.index = index
        
        present(digiSVC, animated: true)
    }
}
    
    
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        let count = fetchedResultController.fetchedObjects?.count ?? 0
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView2.dequeueReusableCell(withIdentifier: "cellDigi") as! DigiTableViewCell)
        
        guard let digimon = fetchedResultController.fetchedObjects?[indexPath.row] else {return cell}
            
        cell.prepare(digimon)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let digimon = fetchedResultController.fetchedObjects?[indexPath.row] else {return}
            context.delete(digimon)
        }
    }
    
    
}

extension HomeViewController: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            if let indexPath = indexPath {
                tableView2.deleteRows(at: [indexPath], with: .fade)
            }
        default:
            tableView2.reloadData()
        }
    }
}


