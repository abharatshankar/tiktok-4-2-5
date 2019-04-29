//
//  DiscoverVC.swift
//  tiktok
//
//  Created by Dr Mohan Roop on 3/21/19.
//  Copyright © 2019 Bharat shankar. All rights reserved.
//

import UIKit

class DiscoverVC: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    
    
    @IBOutlet weak var firstCollection: UICollectionView!
    
    @IBOutlet weak var TrendingTV: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        TrendingTV.delegate = self
        TrendingTV.dataSource = self
        // Do any additional setup after loading the view.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        // In this function is the code you must implement to your code project if you want to change size of Collection view
        let width  = (view.frame.width-20)/3
        if self.firstCollection == collectionView {
            return CGSize(width: 115, height: 135)
        }
        else
        {
            
            return CGSize(width: width, height: width)
        }
        
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstCollectionViewCell", for: indexPath) as! FirstCollectionViewCell
        cell.firstImage.image = UIImage(named: "2")
        shadowView(view: cell.firstImage)
        
        return cell
    }
    
    
 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingCell", for: indexPath)  as! TrendingCell
       cell.selectionStyle = .none
      
        shadowView(view: cell.myRoundView)
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 255
        
    }

}

