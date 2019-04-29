//
//  TrendingCell.swift
//  tiktok
//
//  Created by Dr Mohan Roop on 3/21/19.
//  Copyright © 2019 Bharat shankar. All rights reserved.
//

import UIKit
import FLAnimatedImage

class TrendingCell: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegate {
    
    var myArrayData = [[String:Any]]()
    
    var rawDict =  [String:Any]()
    
    
    @IBOutlet weak var myRoundView: UIView!
    
    @IBOutlet weak var trendingCollection: UICollectionView!
    
    @IBOutlet weak var viewAllAction: UIButton!
    
    @IBOutlet weak var hashTagNameLbl: UILabel!
    
    @IBOutlet weak var buttonImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        trendingCollection.delegate = self
        trendingCollection.dataSource = self
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.myArrayData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendingCollectionCell", for: indexPath) as! TrendingCollectionCell
        
        
        
//            let gifURL : String = "https://upload.wikimedia.org/wikipedia/commons/2/2c/Rotating_earth_%28large%29.gif"
//            let imageURL = UIImage.gifImageWithURL(gifURL)
        var myUrl : URL!
        
        let tempDic = self.myArrayData[indexPath.row]
        
        if let templink  = tempDic["video"] as? String{
            var myStr = templink
            
            myStr = myStr.dropLast(3) + "gif"
            myUrl  =  URL(string: GIF_VIDEO_URL+myStr )
            
            let imageData = try? Data(contentsOf: myUrl)
            let imageData3 = FLAnimatedImage(animatedGIFData: imageData)
            DispatchQueue.main.async {
            cell.trendingImg.animatedImage = imageData3
            }
        }
        
        
        
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        DispatchQueue.main.async {
            let tempDic = self.myArrayData[indexPath.row]
            
            if let templink  = tempDic["video"] as? String{
                initialUrl  =  URL(string: TEMP_VIDEO_URL+templink )
            }
            
            let mySelectedVideo:[String: Int] = ["songIndex": collectionView.tag]
            
            NotificationCenter.default.post(name: Notification.Name("mySelectedVideo"), object: nil , userInfo :mySelectedVideo)

        }
        
        

        
    }
    
    

}
