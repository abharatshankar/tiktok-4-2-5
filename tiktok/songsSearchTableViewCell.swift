//
//  songsSearchTableViewCell.swift
//  tiktok
//
//  Created by Bharat shankar on 23/04/19.
//  Copyright © 2019 Bharat shankar. All rights reserved.
//

import UIKit

class songsSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var songNameLbl: UILabel!
    
    @IBOutlet weak var movieNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
