//
//  commentReplyTableViewCell.swift
//  tiktok
//
//  Created by Bharat shankar on 10/04/19.
//  Copyright © 2019 Bharat shankar. All rights reserved.
//

import UIKit

class commentReplyTableViewCell: UITableViewCell {

    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var commentLbl: UILabel!
    @IBOutlet weak var commentReplyLbl: UILabel!
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var replyBtn: UIButton!
    @IBOutlet weak var likeBtn: UIButton!
    
    @IBOutlet weak var likesCountLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
