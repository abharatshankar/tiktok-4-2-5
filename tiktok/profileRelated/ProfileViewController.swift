//
//  ProfileViewController.swift
//  tiktok
//
//  Created by ashwin challa on 2/18/19.
//  Copyright © 2019 Bharat shankar. All rights reserved.
//

import UIKit
import Toast_Swift
import FBSDKCoreKit

class ProfileViewController: UIViewController ,UITabBarControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource{

    @IBOutlet weak var editProfileBtn: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var hearVideosImgView: UIImageView!
    @IBOutlet weak var yourVideosImgView: UIImageView!
    @IBOutlet weak var heartsBtn: UIButton!
    @IBOutlet weak var yourVideosBtn: UIButton!
    @IBOutlet weak var videosCollection: UICollectionView!
    var imagesArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        imagesArray = ["0d8136205e0742312c6fbbff0a225de7.jpg", "d91209340bdc005936c46323a62caaff.png","download.png","graphics-png-1.png","0d8136205e0742312c6fbbff0a225de7.jpg", "d91209340bdc005936c46323a62caaff.png","download.png","graphics-png-1.png","0d8136205e0742312c6fbbff0a225de7.jpg", "d91209340bdc005936c46323a62caaff.png","download.png","graphics-png-1.png"]
        // Do any additional setup after loading the view.
        
        let color1 = hexStringToUIColor(hex: "#8D00F7")
        self.navigationController?.navigationBar .barTintColor = color1
        
        self.profileImage.layer.cornerRadius = 45
        self.profileImage.layer.masksToBounds = true
        
        self.tabBarController?.tabBar.isTranslucent = true
        
        
        let leftItem = UIBarButtonItem(title: "Johnnydemo",
                                       style: UIBarButtonItem.Style.plain,
                                       target: nil,
                                       action: nil)
        
        leftItem.isEnabled = false
        self.navigationItem.leftBarButtonItem = leftItem

        
        
//        let button = UIButton(type: UIButton.ButtonType.custom)
//        button.setImage(UIImage(named: "yourImageName.png"), for: UIControl.State.Normal)
//        button.addTarget(self, action:Selector("callMethod"), for: UIControl.Event.TouchDragInside)
//        button.frame=CGRect(x:0, y:0,width: 30,height: 30)
//        let barButton = UIBarButtonItem(customView: button)
//        self.navigationItem.leftBarButtonItems = [newBackButton,barButton]
        
        self.tabBarController?.tabBar.isHidden = false
        
        
        /////////////////////////for right bar buttons/////////////////////////////////
        
        // for menu burger icon
        let burgerBtn = UIButton(type: UIButton.ButtonType.custom)
        burgerBtn.setImage(UIImage(named:"menu-burger-36"), for: UIControl.State())
        burgerBtn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        let burgerBtnItem = UIBarButtonItem(customView: burgerBtn)
        let width1 = burgerBtnItem.customView?.widthAnchor.constraint(equalToConstant: 22)
        width1?.isActive = true
        let height1 = burgerBtnItem.customView?.heightAnchor.constraint(equalToConstant: 22)
        height1!.isActive = true
        
        
        
        
        // for add friends icon
        let addfriendsBtn = UIButton(type: UIButton.ButtonType.custom)
        addfriendsBtn.setImage(UIImage(named:"add-frinds-36"), for: UIControl.State())
        addfriendsBtn.addTarget(self, action: #selector(SecondbuttonAction), for: .touchUpInside)
        let addfriendsBarItem = UIBarButtonItem(customView: addfriendsBtn)
        let width2 = addfriendsBarItem.customView?.widthAnchor.constraint(equalToConstant: 30)
        width2?.isActive = true
        let height2 = addfriendsBarItem.customView?.heightAnchor.constraint(equalToConstant: 30)
        height2!.isActive = true
        
        
        
        
        
        // for add favourites icon
        let addfavouritesBtn = UIButton(type: UIButton.ButtonType.custom)
        addfavouritesBtn.setImage(UIImage(named:"add-fav-white-36"), for: UIControl.State())
        addfavouritesBtn.addTarget(self, action: #selector(ThirdbuttonAction), for: .touchUpInside)
        let addfavouritesBarItem = UIBarButtonItem(customView: addfavouritesBtn)
        let width3 = addfavouritesBarItem.customView?.widthAnchor.constraint(equalToConstant: 30)
        width3?.isActive = true
        let height3 = addfavouritesBarItem.customView?.heightAnchor.constraint(equalToConstant: 30)
        height3!.isActive = true
        
        navigationItem.rightBarButtonItems = [burgerBtnItem,addfriendsBarItem,addfavouritesBarItem]
        
        

    }
    
    
    
    @objc func buttonAction()
    {
//        let storyBoard = UIStoryboard(name:"Main", bundle:nil)
//        let cart = storyBoard.instantiateViewController(withIdentifier: "CartViewController")
//        self.navigationController?.pushViewController(cart, animated: true)
        
    }
    @objc func SecondbuttonAction()
    {

        if(DEFAULT_HELPER.getId().isEmpty != true && DEFAULT_HELPER.getId() != "")
        {
            
        }
        else if(DEFAULT_HELPER.getfbId().isEmpty != true && DEFAULT_HELPER.getfbId() != "")
        {
            
        }
        else
        {
            let storyBoard = UIStoryboard(name:"Main", bundle:nil)
            let signup = storyBoard.instantiateViewController(withIdentifier: "signupVC")
            self.navigationController?.pushViewController(signup, animated: true)
        }
        
        
    }
    
    @objc func ThirdbuttonAction()
    {
        //        let storyBoard = UIStoryboard(name:"Main", bundle:nil)
        //        let notification = storyBoard.instantiateViewController(withIdentifier: "NotificationViewController")
        //        self.navigationController?.pushViewController(notification, animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
//        UITabBar.appearance().barTintColor = UIColor.gray
//        UITabBar.appearance().backgroundColor = UIColor.gray
    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        UITabBar.appearance().barTintColor = UIColor.clear
//        UITabBar.appearance().backgroundColor = UIColor.clear
    }

    
    @IBAction func yourVideosAction(_ sender: Any) {
        imagesArray = ["0d8136205e0742312c6fbbff0a225de7.jpg", "d91209340bdc005936c46323a62caaff.png","download.png","graphics-png-1.png","0d8136205e0742312c6fbbff0a225de7.jpg", "d91209340bdc005936c46323a62caaff.png","download.png","graphics-png-1.png","0d8136205e0742312c6fbbff0a225de7.jpg", "d91209340bdc005936c46323a62caaff.png","download.png","graphics-png-1.png"]
        self.yourVideosBtn.setTitleColor(UIColor.darkGray, for: .normal)
        self.yourVideosImgView.image = UIImage(named: "list-video-black-36")
        self.heartsBtn.setTitleColor(UIColor.lightGray, for: .normal)
        self.hearVideosImgView.image = UIImage(named: "hearts-gray-36")
        self.videosCollection.reloadData()
    }
    
    @IBAction func heartVideosAction(_ sender: Any) {
        imagesArray = ["1.png", "2.png","3.png","4.jpeg", "1.jpg", "2.png","3.png","4.jpeg","1.jpg", "2.png","3.png","4.jpeg","1.jpg", "2.png","3.png","4.jpeg","1.jpg", "2.png","3.png","4.jpeg"]
        self.hearVideosImgView.image = UIImage(named: "hearts-black-36")
        self.heartsBtn.setTitleColor(UIColor.darkGray, for: .normal)
        self.yourVideosBtn.setTitleColor(UIColor.lightGray, for: .normal)
        self.yourVideosImgView.image = UIImage(named: "list-video-gray-36")
        self.videosCollection.reloadData()
    }
    
    
    // navigation bar color code
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    
    {
        return imagesArray.count
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileVideosCollectionViewCell", for: indexPath) as! profileVideosCollectionViewCell
        
        cell.mainImg.image = UIImage(named: self.imagesArray[indexPath.row] as String)
        
        
        
        return cell
    }
    
    
    

}
