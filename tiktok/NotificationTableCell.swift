//
//  NotificationTableCell.swift
//  tiktok
//
//  Created by Dr Mohan Roop on 4/7/19.
//  Copyright © 2019 Bharat shankar. All rights reserved.
//

import UIKit

class NotificationTableCell: UITableViewCell {
    
    
    @IBOutlet weak var notificationImg: UIImageView!
    
    @IBOutlet weak var NotificationTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
