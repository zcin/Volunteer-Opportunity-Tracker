//
//  ExploreVCViewController.swift
//  Volunteer Opportunity Tracker
//
//  Created by Cindy Zhang on 3/4/18.
//  Copyright © 2018 Cindy Zhang. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController {
    
    let manager = EventsDataManager.sharedInstance

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        manager.updateEventsFromArchive()
        tableView.reloadData()
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
        
        
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = e.photo
        backgroundImage.contentMode =  UIViewContentMode.scaleToFill
        cell.contentView.insertSubview(backgroundImage, at: 0)
        //cell.contentView.backgroundColor = UIColor(patternImage: UIImage(named:"Select")!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.getNumberOfItems()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            manager.removeEvent(indexPath)
            manager.saveEventsToArchive()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
}

extension ExploreViewController: UITableViewDelegate {

}

