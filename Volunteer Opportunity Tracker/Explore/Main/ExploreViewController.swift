//
//  ExploreVCViewController.swift
//  Volunteer Opportunity Tracker
//
//  Created by Cindy Zhang on 3/4/18.
//  Copyright © 2018 Cindy Zhang. All rights reserved.
//

import UIKit
//import SDWebImage

class ExploreViewController: UIViewController, UITableViewDelegate {
    
    var manager : EventsDataManager!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager = EventsDataManager.sharedInstance
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        manager.updateEvents(){
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is EventDetailViewController {
            if let indexPath = tableView.indexPathForSelectedRow{
                let currentCell = tableView.cellForRow(at: indexPath) as! ExploreEventCell
                
                let destinationVC = segue.destination as? EventDetailViewController
                
                destinationVC?.manager = manager
                destinationVC?.event = manager.getItem(at: indexPath)
                destinationVC?.photo = currentCell.backgroundImageView.image!
            }
        }
    }
}

extension ExploreViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExploreEventCell", for: indexPath) as! ExploreEventCell
        
        let e = manager.getItem(at: indexPath)
        cell.title.text = e.name
        cell.subtitle.text = e.location
        cell.backgroundImageView.loadImageUsingCacheWithURLString(urlString: e.imageURL)
        
        return cell
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.getNumberOfItems()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            manager.removeEventFromDatabase(indexPath)
            manager.updateEvents {
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

