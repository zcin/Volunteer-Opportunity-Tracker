//
//  ExploreEventCellTableViewCell.swift
//  Volunteer Opportunity Tracker
//
//  Created by Cindy Zhang on 3/9/18.
//  Copyright © 2018 Cindy Zhang. All rights reserved.
//

import UIKit

class ExploreEventCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
