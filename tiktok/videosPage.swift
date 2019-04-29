//
//  videosPage.swift
//  tiktok
//
//  Created by Bharat shankar on 20/04/19.
//  Copyright © 2019 Bharat shankar. All rights reserved.
//

import UIKit

class videosPage: UIViewController ,UICollectionViewDataSource, UICollectionViewDelegate{

    
    @IBOutlet weak var videosCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: self.view.frame.size.width/3, height: self.view.frame.size.width/3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        videosCollection!.collectionViewLayout = layout
    }
    

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 20
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videopageCollectionViewCell", for: indexPath) as! videopageCollectionViewCell
        
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if indexPath.row == 0
        {
            return CGSize(width: self.view.frame.size.width, height: 175)
        }
        return CGSize(width: self.view.frame.size.width/3, height: 175);
        
    }

}
