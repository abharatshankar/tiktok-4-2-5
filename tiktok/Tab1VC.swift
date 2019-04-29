//
//  Tab1VC.swift
//  Tabbar
//
//  Created by Ketan on 7/26/17.
//  Copyright © 2017 kETANpATEL. All rights reserved.
//

import UIKit
import Photos

class Tab1VC: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource {
    
    @IBOutlet weak var myCollectionview: UICollectionView!
    
    var imageArray = [UIImage]()
    
    var selectedArray = [Int]()
    
    
    let imgManager = PHImageManager.default()
    
    let requestOptions = PHImageRequestOptions()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // this is to set collectionview cells size perferfectly fit
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: self.view.frame.size.width/3, height: self.view.frame.size.width/3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        myCollectionview!.collectionViewLayout = layout
        
        
        
        
        
        //////////////////////////////////////
        //////////////////////////////////////
        
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .highQualityFormat
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        if let fetchResult : PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        {
            if fetchResult.count > 0 {
                for i in 0..<fetchResult.count
                {
                    imgManager.requestImage(for: fetchResult.object(at: i), targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFill, options: requestOptions) { (image, error) in
                        
                        self.imageArray.append(image!)
                    }
                }
                
                print("my totla images are",self.imageArray.count)
                
                
                self.myCollectionview.reloadData()
            }
        }
        //////////////////////////////////////
        //////////////////////////////////////
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if indexPath.row == 0
        {
            return CGSize(width: self.view.frame.size.width, height: self.view.frame.size.width/3)
        }
        return CGSize(width: self.view.frame.size.width/3, height: self.view.frame.size.width/3);
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.imageArray.count
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imagesCollectionViewCell", for: indexPath) as! imagesCollectionViewCell
        
        cell.imagesCell.image = self.imageArray[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedCell : imagesCollectionViewCell = collectionView.cellForItem(at: indexPath)! as! imagesCollectionViewCell
        
        if(self.selectedArray.count > 4){
            
            if(self.selectedArray.contains(indexPath.row)){
                selectedCell.layer.borderWidth = 0
                selectedCell.layer.borderColor = UIColor.clear.cgColor
                self.selectedArray = self.selectedArray.filter {$0 != indexPath.row}
            }
            else
            {
                self.view.makeToast("Maxium items selected")
            }
        }
        else
        {
            if(self.selectedArray.contains(indexPath.row)){
                selectedCell.layer.borderWidth = 0
                selectedCell.layer.borderColor = UIColor.clear.cgColor
                self.selectedArray = self.selectedArray.filter {$0 != indexPath.row}
                
            }
            else
            {
                self.selectedArray.append(indexPath.row)
                selectedCell.layer.borderWidth = 3
                selectedCell.layer.borderColor = UIColor.red.cgColor
            }
        }
        
        print("myoriginal array ",self.selectedArray)
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 160.0, height: 160.0)
    }
    
    
}
