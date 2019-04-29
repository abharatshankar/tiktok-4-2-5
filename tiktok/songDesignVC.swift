//
//  songDesignVC.swift
//  tiktok
//
//  Created by Bharat shankar on 29/04/19.
//  Copyright © 2019 Bharat shankar. All rights reserved.
//

import UIKit


class songDesignVC: UIViewController,FSPagerViewDelegate,FSPagerViewDataSource {

    
    @IBOutlet weak var useSoundBtn: UIButton!
    
    @IBOutlet weak var tryAnotherBtn: UIButton!
    
    
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.pagerView.itemSize = FSPagerView.automaticSize
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tryAnotherBtn.layer.borderColor = UIColor.white.cgColor
        self.tryAnotherBtn.layer.borderWidth = 1
        
        self.pagerView.automaticSlidingInterval = 3.0 - self.pagerView.automaticSlidingInterval
        
        
    }
    
    
    

    
    // MARK:- FSPagerView DataSource
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return 10
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: "dummyImg.jpg"/*self.imageNames[index]*/)
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        cell.textLabel?.text = index.description+index.description
        return cell
    }
    
    // MARK:- FSPagerView Delegate
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        //self.pageControl.currentPage = targetIndex
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        //self.pageControl.currentPage = pagerView.currentIndex
    }
    
    
    
}
