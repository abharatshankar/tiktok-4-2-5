//
//  AlignedCollectionVC.swift
//  tiktok
//
//  Created by Dr Mohan Roop on 3/19/19.
//  Copyright © 2019 Bharat shankar. All rights reserved.
//

import UIKit
import AlignedCollectionViewFlowLayout

class AlignedCollectionVC: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
  
   
    @IBOutlet weak var alignedCollection: UICollectionView!
    
    let tags1 = ["When you", "eliminate", "the impossible,", "whatever remains,", "however improbable,", "must be", "the truth."]
    let tags2 = ["Of all the souls", "I have", "encountered", "in my travels,", "his", "was the most…", "human."]
    let tags3 = ["Computers", "make", "excellent", "and", "efficient", "servants", "but", "I", "have", "no", "wish", "to", "serve", "under", "them."]
    
    var dataSource: [[String]] = [[]]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            alignedCollection.delegate = self
            alignedCollection.dataSource = self
        
        dataSource = [tags1, tags2, tags3]
        
        // Set up the flow layout's cell alignment:
        let flowLayout = alignedCollection?.collectionViewLayout as? AlignedCollectionViewFlowLayout
        flowLayout?.horizontalAlignment = .justified
        flowLayout?.verticalAlignment = .center
        
        // Enable automatic cell-sizing with Auto Layout:
        flowLayout?.estimatedItemSize = .init(width: 100, height: 40)


        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        alignedCollection.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource[section].count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlignedCollectionViewCell", for: indexPath) as! AlignedCollectionViewCell
        
        
        cell.itemName.text = dataSource[indexPath.section][indexPath.item]
        
        cell.itemName.layer.cornerRadius = 20
        
//        DispatchQueue.main.async {
//            self.alignedCollection.reloadData()
//        }
        
        return cell
        
    }

   
    @IBAction func submitAction(_ sender: Any) {
        
    }
    
}
