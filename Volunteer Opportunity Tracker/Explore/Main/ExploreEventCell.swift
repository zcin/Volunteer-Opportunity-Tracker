//
//  ExploreEventCellTableViewCell.swift
//  Volunteer Opportunity Tracker
//
//  Created by Cindy Zhang on 3/9/18.
//  Copyright © 2018 Cindy Zhang. All rights reserved.
//

import UIKit
import SDWebImage

class ExploreEventCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundImageView.contentMode = .scaleAspectFill
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        backgroundImageView.image = nil
    }
}
