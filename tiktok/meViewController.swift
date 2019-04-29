//
//  meViewController.swift
//  tiktok
//
//  Created by Bharat shankar on 06/03/19.
//  Copyright © 2019 Bharat shankar. All rights reserved.
//

import UIKit
import SDWebImage

class meViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {

    
    var myBioData = ""
    var followersCountStr = ""
    var followingCountStr = ""
    var fullnameStr = ""
    var idstr = ""
    var likesStr = ""
    var photoStr = ""
    var videosCountStr = ""
    
    
    
    @IBOutlet weak var videosCollection: UICollectionView!
    var headerButtonsDict = [String:String]()
    let defaultsHpr = DefaultsHelper.init()
    @IBOutlet weak var yourVideosBtn: UIButton!
    
    @IBOutlet weak var heartVideosBtn: UIButton!
    @IBOutlet weak var yourVideosImg: UIImageView!
    
    @IBOutlet weak var heartVideosImg: UIImageView!
    
    var testingArr = [String]()
    
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nil, bundle: nil)
//        if self.defaultsHpr.getfbId() != "" {
//            let storyBoard = UIStoryboard(name:"Main", bundle:nil)
//            let otp = storyBoard.instantiateViewController(withIdentifier: "signupVC") as! signupVC
//
//            self.navigationController?.pushViewController(otp, animated: true)
//        }
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
                    testingArr = ["my","testing","array is this"]
                    
                    
                    self.headerButtonsDict = ["yourVideos": "1", "hearts": "0"]
                    
                    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                    layout.sectionInset = UIEdgeInsets(top: 0, left: 2, bottom: 10, right: 2)
                    layout.itemSize = CGSize(width: videosCollection.frame.size.width/3, height: videosCollection.frame.size.width/3)
                    layout.minimumInteritemSpacing = 2
                    layout.minimumLineSpacing = 2
                    videosCollection!.collectionViewLayout = layout
                    
                    
                    
                    
                    let color1 = hexStringToUIColor(hex: "#8D00F7")
                    self.navigationController?.navigationBar .barTintColor = color1
                    
                    self.tabBarController?.tabBar.isTranslucent = true
                    
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
        
        
        
            if(Reachability.isConnectedToNetwork() == true)
            {
                DispatchQueue.main.async {
                    showLoading(view: self.view)
                }
                if(DEFAULT_HELPER.getId() != "")
                {
                    if(DEFAULT_HELPER.getId().isEmpty == true)
                    {
                        self.view.makeToast("Not registered Yet")
                    }else
                    {
                        self.profilePostCall(url: PROFILE_PAGE, myuserId: DEFAULT_HELPER.getId())
                    }
                    
                }
                else if(DEFAULT_HELPER.getfbId() != "")
                {
                    if(DEFAULT_HELPER.getfbId().isEmpty == true)
                    {
                        self.view.makeToast("Not registered Yet")
                    }else
                    {
                        self.profilePostCall(url: PROFILE_PAGE, myuserId: DEFAULT_HELPER.getfbId())
                    }
                    
                }
                
            }
            else
            {
                self.view.makeToast("Check your Connection")
            }
        
        
        
        
              
    }
    
    
    @IBAction func editProfileAction(_ sender: Any) {
        //editProfileVC
        
        let editProfile = storyboard?.instantiateViewController(withIdentifier: "editProfileVC") as! editProfileVC
        navigationController?.pushViewController(editProfile, animated: false)
    }
    
    
    @objc func yourVideosAction()
    {
        print("check your videos")
        
        self.headerButtonsDict["yourVideos"] = "1"
        self.headerButtonsDict["hearts"] = "0"
        self.videosCollection.reloadData()
        
        
    }
    
    @objc func heartVideosAction()
    {
        print("check heart videos")
        self.headerButtonsDict["yourVideos"] = "0"
        self.headerButtonsDict["hearts"] = "1"
        self.videosCollection.reloadData()
        
    }
    
    
    @objc func buttonAction()
    {
                let storyBoard = UIStoryboard(name:"Main", bundle:nil)
                let cart = storyBoard.instantiateViewController(withIdentifier: "SettingsViewController")
                self.navigationController?.pushViewController(cart, animated: true)
        
    }
    @objc func SecondbuttonAction()
    {
                if(defaultsHpr.getfbId() != ""){
        
                    self.view.makeToast("sige")
                }
                else if(defaultsHpr.getId() != ""){
                    
                    self.view.makeToast("sige")
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
                let storyBoard = UIStoryboard(name:"Main", bundle:nil)
        let notification = storyBoard.instantiateViewController(withIdentifier: "favouritesVC") as! favouritesVC
        notification.height = 600
        notification.topCornerRadius = 20
        notification.presentDuration = 0.51
        notification.dismissDuration = 0.51
        notification.shouldDismissInteractivelty = true
        notification.popupDelegate = self
        self.present(notification, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "middleButton"), object: nil, userInfo: nil)
        self.profileService()
        self.videosCollection.reloadData()
        //        UITabBar.appearance().barTintColor = UIColor.gray
        //        UITabBar.appearance().backgroundColor = UIColor.gray
    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        UITabBar.appearance().barTintColor = UIColor.clear
//        UITabBar.appearance().backgroundColor = UIColor.clear
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat((122)), height: CGFloat(122))
        //return CGSize(width: CGFloat((135)), height: CGFloat(135)) //--> this is to above x & plus models
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
     {
        
            return 0
        
        
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if indexPath.row == 0
        {
            return CGSize(width: videosCollection.frame.size.width, height: videosCollection.frame.size.width/3)
        }
        return CGSize(width: videosCollection.frame.size.width/3, height: videosCollection.frame.size.width/3);
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        //return CGSize(width: self.videosCollection.bounds.width, height: 427)
        return .init(width: view.frame.width, height: 427)
    }
    
    
    

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
                switch kind {
        
                case UICollectionView.elementKindSectionHeader:
        
        
                    let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath as IndexPath) as! headerCollectionReusableView
                   // headerView.yourVideosImg
        
                    headerView.yourVideosBtn.addTarget(self, action: #selector(yourVideosAction), for: .touchUpInside)
                    let myYourVideoTitle = headerButtonsDict["yourVideos"] as! String
                    
                    
                    if(myYourVideoTitle == "1") // for your videos button active mode
                    {
                        
                        headerView.yourVideosBtn.setTitleColor(#colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1), for: .normal)
                        headerView.heartVideosBtn.setTitleColor(#colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1), for: .normal)
                         headerView.yourVideosImg.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: "list-video-black-36"))
                        headerView.heartVideosImg.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: "whiteHeart"))
                        headerView.profileName.text = self.fullnameStr
                        
                        headerView.bioTextLbl.text = self.myBioData
                        headerView.followersCountLbl.text = self.followersCountStr + " Followers"
                        headerView.followingCountLbl.text = self.followingCountStr + " Following"
                        headerView.likesCountLbl.text = self.likesStr + " Hearts"
                        headerView.videosCountLbl.text = self.videosCountStr + " Videos"
                        
                        headerView.profileImage.sd_setImage(with: URL(string: DISPLAY_PROFILE_PIC+self.photoStr), placeholderImage: UIImage(named: "profile-72"))
                        
                        headerView.profileImage.layer.cornerRadius = headerView.profileImage.frame.size.width/2
                        
                        headerView.profileImage.layer.borderColor = UIColor.white.cgColor
                        
                        headerView.profileImage.layer.borderWidth = 2
                        
                        headerView.profileImage.layer.masksToBounds = true
                    }
                    else // for heart videos button active mode
                    {
                       
                        headerView.yourVideosBtn.setTitleColor(#colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1), for: .normal)
                        headerView.heartVideosBtn.setTitleColor(#colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1), for: .normal)
                        headerView.yourVideosImg.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: "list-video-gray-36"))
                         headerView.heartVideosImg.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: "redHeart"))
                        
                        
                    }
                    
                    
                    
                    headerView.heartVideosBtn.addTarget(self, action: #selector(heartVideosAction), for: .touchUpInside)
        
                    headerView.backgroundColor = UIColor.green
             
                     headerView.profileImage.layer.cornerRadius =  headerView.profileImage.frame.size.width / 2
                    headerView.profileImage.layer.masksToBounds = true
                    
                    return headerView
        
        
                default:
        
                    assert(false, "Unexpected element kind")
                }
        
            }

//     func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
//
//        switch kind {
//
//        case UICollectionView.elementKindSectionHeader:
//
//
//            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath as IndexPath) as! headerCollectionReusableView
//           // headerView.yourVideosImg
//
//            headerView.yourVideosBtn.addTarget(self, action: #selector(yourVideosAction), for: .touchUpInside)
//
//            headerView.heartVideosBtn.addTarget(self, action: #selector(heartVideosAction), for: .touchUpInside)
//
//            headerView.backgroundColor = UIColor.green
//
//            return headerView
//
//
//        default:
//
//            assert(false, "Unexpected element kind")
//        }
//
//    }
    
    
    func profilePostCall(url : String , myuserId : String){
        
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        let postString = "userId=\(myuserId)"
        
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                DispatchQueue.main.async {
                    hideLoading(view: self.view)
                }
                
                print("error=\(error)")
                return
            }
            
            do {
                DispatchQueue.main.async {
                    hideLoading(view: self.view)
                }
                
                if let responseJSON = try JSONSerialization.jsonObject(with: data!) as? [String:AnyObject]{
                    print(responseJSON)
                    
                    
                    
                    if(responseJSON["status"] as! Int == 0)
                    {
                        
                        if let mydata = responseJSON["data"] as? NSDictionary{
                            if let myBio = mydata["bioData"] as? String{
                                self.myBioData = myBio
                            }
                            
                            if let myfollowers = mydata["followers"] as? String{
                                self.followersCountStr = myfollowers
                            }
                            
                            if let myFollowing = mydata["following"] as? String{
                                self.followingCountStr = myFollowing
                            }
                            
                            if let myFullname = mydata["fullName"] as? String{
                                self.fullnameStr = myFullname
                            }
                            
                            if let mylikes = mydata["likes"] as? String{
                                self.likesStr = mylikes
                            }
                            
                            if let myPhotoStr = mydata["photo"] as? String{
                                self.photoStr = myPhotoStr
                            }
                            
                            if let myvideosStr = mydata["videos"] as? String{
                                self.videosCountStr = myvideosStr
                            }
                            
                        }
                        DispatchQueue.main.async {
                            hideLoading(view: self.view)
                            
                            self.videosCollection.reloadData()
                        }
                        
                    }
                    else if(responseJSON["status"] as! Int == 1)
                    {
                        
                        DispatchQueue.main.async {
                            hideLoading(view: self.view)
                            
                        }
                    }
                    else if(responseJSON["status"] as! Int == 9)
                    {
                        DispatchQueue.main.async {
                            hideLoading(view: self.view)
                            self.view.makeToast("Unable to get profile")
                        }
                        
                    }
                    
                    
                    
                    
                }
            }
            catch {
                print("Error -> \(error)")
                DispatchQueue.main.async {
                    hideLoading(view: self.view)
                }
                
            }
            
            
            
        }
        
        
        task.resume()
        
        
        
    }
    
    func profileService()  {
        
        if(Reachability.isConnectedToNetwork() == true)
        {
            DispatchQueue.main.async {
                showLoading(view: self.view)
            }
            if(DEFAULT_HELPER.getId() != "")
            {
                if(DEFAULT_HELPER.getId().isEmpty == true)
                {
                    self.view.makeToast("Not registered Yet")
                }else
                {
                    self.profilePostCall(url: PROFILE_PAGE, myuserId: DEFAULT_HELPER.getId())
                }
                
            }
            else if(DEFAULT_HELPER.getfbId() != "")
            {
                if(DEFAULT_HELPER.getfbId().isEmpty == true)
                {
                    self.view.makeToast("Not registered Yet")
                }else
                {
                    self.profilePostCall(url: PROFILE_PAGE, myuserId: DEFAULT_HELPER.getfbId())
                }
                
            }
            
        }
        else
        {
            DispatchQueue.main.async {
                hideLoading(view: self.view)
                self.view.makeToast("Check your Connection")
            }
            
        }
        
    }

}



extension meViewController: BottomPopupDelegate {
    
    func bottomPopupViewLoaded() {
        showLoading(view: self.view)
        print("bottomPopupViewLoaded")
    }
    
    func bottomPopupWillAppear() {
        print("bottomPopupWillAppear")
    }
    
    func bottomPopupDidAppear() {
        print("bottomPopupDidAppear")
        
    }
    
    func bottomPopupWillDismiss() {
        print("bottomPopupWillDismiss")
    }
    
    func bottomPopupDidDismiss() {
        hideLoading(view: self.view)
        print("bottomPopupDidDismiss")
    }
    
    func bottomPopupDismissInteractionPercentChanged(from oldValue: CGFloat, to newValue: CGFloat) {
        print("bottomPopupDismissInteractionPercentChanged fromValue: \(oldValue) to: \(newValue)")
    }
}
