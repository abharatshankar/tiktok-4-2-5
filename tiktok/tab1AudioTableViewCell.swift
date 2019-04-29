//
//  tab1AudioTableViewCell.swift
//  tiktok
//
//  Created by Bharat shankar on 01/04/19.
//  Copyright © 2019 Bharat shankar. All rights reserved.
//

import UIKit



class tab1AudioTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var playButton: UIButton!
    
    
    @IBOutlet weak var nameTxtLbl: UILabel!
    
    @IBOutlet weak var audioBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
