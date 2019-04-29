//
//  SettingsTableViewCell.swift
//  tiktok
//
//  Created by ashwin challa on 4/22/19.
//  Copyright © 2019 Bharat shankar. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var settingsImage: UIImageView!
    @IBOutlet weak var settingsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
