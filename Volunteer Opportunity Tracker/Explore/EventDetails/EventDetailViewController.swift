//
//  EventDetailViewController.swift
//  Volunteer Opportunity Tracker
//
//  Created by Cindy Zhang on 3/14/18.
//  Copyright © 2018 Cindy Zhang. All rights reserved.
//

import UIKit

class EventDetailViewController: UITableViewController {
//    var manager : EventsDataManager!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var spotsRemaining: UILabel!
    @IBOutlet weak var spotsTaken: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var event = EventObject()
    var photo = UIImage()
    var manager = EventsDataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = event.name
        locationLabel.text = event.location
        addressLabel.text = event.address
        headerImage.contentMode = .scaleAspectFill
        headerImage.image = photo
        
        titleLabel.sizeToFit()
        locationLabel.sizeToFit()
        addressLabel.sizeToFit()
        
        spotsRemaining.text = String(event.spotsRemaining)
        spotsTaken.text = String(event.spotsTaken)
        
        descriptionTextView.text = event.eventDescription
        descriptionTextView.sizeToFit()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction func signUpForEvent(_ sender: UIButton) {
        event.spotsRemaining -= 1
        event.spotsTaken += 1
        
        spotsRemaining.text = String(event.spotsRemaining)
        spotsTaken.text = String(event.spotsTaken)
        
        manager.updateEventSpotsOnDatabase(event)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.item {
        case 1:
            return descriptionTextView.bounds.size.height + 63
        case 4:
            return 87
        default:
            return UITableViewAutomaticDimension
        }
        
    }

    // MARK: - Table view data source

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
