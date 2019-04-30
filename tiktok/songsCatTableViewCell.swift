//
//  songsCatTableViewCell.swift
//  tiktok
//
//  Created by Bharat shankar on 29/04/19.
//  Copyright © 2019 Bharat shankar. All rights reserved.
//

import UIKit

class songsCatTableViewCell: UITableViewCell {

    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var viewAllBtn: UIButton!
    
    
    @IBOutlet weak var catSelection: UICollectionView!
    
    
    @IBOutlet weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
