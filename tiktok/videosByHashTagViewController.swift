//
//  videosByHashTagViewController.swift
//  tiktok
//
//  Created by Bharat shankar on 19/04/19.
//  Copyright © 2019 Bharat shankar. All rights reserved.
//

import UIKit
import FLAnimatedImage

class videosByHashTagViewController: UIViewController  , UICollectionViewDelegate , UICollectionViewDataSource{

    @IBOutlet weak var videosCollection: UICollectionView!
    
    @IBOutlet weak var hashTagName: UILabel!
    
    @IBOutlet weak var pageTitleLbl: UILabel!
    
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var VideosCount: UILabel!
    
    
    
    var videosArray = [[String:Any]]()
    
    var rawData = [String:Any]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if (self.rawData.keys.contains("hashTag")) {
            if let myTag = self.rawData["hashTag"] as? String{
                self.pageTitleLbl.text = myTag
                self.hashTagName.text = myTag
            }
        }
        
        if self.videosArray.count > 0 {
            self.VideosCount.text = String(self.videosArray.count)
        }
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: self.view.frame.size.width/3, height: 158)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        videosCollection!.collectionViewLayout = layout
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.videosArray.count
    }
    
    
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
     {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videosByHahsCollectionViewCell", for: indexPath) as! videosByHahsCollectionViewCell
        
        var myUrl : URL!

        let tempDic = self.videosArray[indexPath.row]
        
        if let templink  = tempDic["video"] as? String{
            var myStr = templink

            myStr = myStr.dropLast(3) + "gif"
            myUrl  =  URL(string: GIF_VIDEO_URL+myStr )

            let imageData = try? Data(contentsOf: myUrl)
            let imageData3 = FLAnimatedImage(animatedGIFData: imageData)
            cell.myImageView.animatedImage = imageData3

        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //videosCollectionPreviewVC
        let storyBoard = UIStoryboard(name:"Main", bundle:nil)
        let allVideos = storyBoard.instantiateViewController(withIdentifier: "videosCollectionPreviewVC") as! videosCollectionPreviewVC
        
        allVideos.myUrlsArray = self.videosArray
        
        
        
        let tempDic = self.videosArray[indexPath.row]
        
        if let templink  = tempDic["video"] as? String{
            allVideos.myVideoUrl   =  URL(string: TEMP_VIDEO_URL+templink )
        }
            
        self.present(allVideos, animated: true, completion: nil)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func myRecordBtnAction(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name:"Main", bundle:nil)
        let allVideos = storyBoard.instantiateViewController(withIdentifier: "myVideoView") as! myVideoView
        
        self.present(allVideos, animated: true, completion: nil)
        
    }
    
    
    
}
