//
//  headerCollectionReusableView.swift
//  tiktok
//
//  Created by Bharat shankar on 07/03/19.
//  Copyright © 2019 Bharat shankar. All rights reserved.
//

import UIKit

class headerCollectionReusableView: UICollectionReusableView {
    
    
    @IBOutlet weak var followingCountLbl: UILabel!
    
    @IBOutlet weak var followersCountLbl: UILabel!
    
    @IBOutlet weak var likesCountLbl: UILabel!
    
    @IBOutlet weak var friendsCountLbl: UILabel!
    
    @IBOutlet weak var videosCountLbl: UILabel!
    
    @IBOutlet weak var bioTextLbl: UILabel!
    
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var yourVideosBtn: UIButton!
    
    @IBOutlet weak var heartVideosBtn: UIButton!
    
    @IBOutlet weak var yourVideosImg: UIImageView!
    
    @IBOutlet weak var heartVideosImg: UIImageView!
    
    
    @IBOutlet weak var profileName: UILabel!
    
    @IBAction func yourVideos(_ sender: Any) {
        let samp = meViewController()
        
        print(samp.testingArr)
        
    }
    
}
