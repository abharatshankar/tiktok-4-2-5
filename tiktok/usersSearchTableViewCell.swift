//
//  usersSearchTableViewCell.swift
//  tiktok
//
//  Created by Bharat shankar on 22/04/19.
//  Copyright © 2019 Bharat shankar. All rights reserved.
//

import UIKit

class usersSearchTableViewCell: UITableViewCell {

    
    @IBOutlet weak var userNameLbl: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var followBtn: UIButton!
    
    @IBOutlet weak var bioDataLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
