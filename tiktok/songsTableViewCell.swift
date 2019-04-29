//
//  songsTableViewCell.swift
//  tiktok
//
//  Created by Bharat shankar on 02/04/19.
//  Copyright © 2019 Bharat shankar. All rights reserved.
//

import UIKit

class songsTableViewCell: UITableViewCell {

    
    @IBOutlet var songImg: UIImageView!
    
    @IBOutlet weak var songNameLbl: UILabel!
    
    @IBOutlet weak var selectBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
