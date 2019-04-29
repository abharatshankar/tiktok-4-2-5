//
//  countryTableViewCell.swift
//  tiktok
//
//  Created by Bharat shankar on 01/03/19.
//  Copyright © 2019 Bharat shankar. All rights reserved.
//

import UIKit

class countryTableViewCell: UITableViewCell {

    @IBOutlet weak var countryImgLbl: UIImageView!
    @IBOutlet weak var countryNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
