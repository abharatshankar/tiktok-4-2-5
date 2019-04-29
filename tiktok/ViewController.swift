//
//  ViewController.swift
//  tiktok
//
//  Created by Bharat shankar on 18/02/19.
//  Copyright © 2019 Bharat shankar. All rights reserved.
//

import UIKit
import SDWebImage


var videoUrl = URL(string:"http://testingmadesimple.org/samplevideo.mp4")
class ViewController: UIViewController , CAAnimationDelegate{
    
    var isFirstTime = true
    var urlToShareStr = ""
    var myMutableString = NSMutableAttributedString()

    @IBOutlet weak var comment1Lbl: UILabel!
    
    @IBOutlet weak var comment1Lb2: UILabel!
    
    var myVideoLatestComment = ""
    
    var videoId = ""
    
    var activityViewController = UIActivityViewController(activityItems: [] , applicationActivities: nil)
    
    @IBOutlet weak var progressBarNIB: BRCircularProgressView!

    @IBOutlet weak var shareBtn: UIButton!
    
    @IBOutlet weak var commentsBtn: UIButton!
    
    @IBOutlet weak var userNameLbl: UILabel!
    
    @IBOutlet weak var likeCountLbl: UILabel!
    
    @IBOutlet weak var blackLayerImageView: UIImageView!
    
    @IBOutlet weak var commentsCCountLbl: UILabel!
    
    @IBOutlet weak var shareCountLbl: UILabel!
    
    @IBOutlet weak var likeBtn: UIButton!
    
    @IBOutlet weak var followTickBtn: UIButton!
    var urlsArray = [String]()
    var videoFromServer = [String]()
    var alertView = UIAlertController()
    @IBOutlet weak var playImg: UIImageView!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var thirdViewLabel: UILabel!
    @IBOutlet weak var thirdView: UIView!
    @IBOutlet weak var hashtrag2: UIButton!
    @IBOutlet weak var hashtag1: UIButton!
    @IBOutlet weak var secondViewLabel: UILabel!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var saytextField: UITextField!
    var videoIndex = 0
    let defaultsHlpr = DefaultsHelper.init()
    fileprivate var player = Player()
    var myVideosDataArray = [[String:Any]]()
    
    
    var myCurrentVideoId = ""
    var commentsCount = ""
    
    
    // MARK: object lifecycle
    deinit {
        self.player.willMove(toParent: nil)
        self.player.view.removeFromSuperview()
        self.player.removeFromParent()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(PROGRESS_BAR_NOTIFICATION), object: nil)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.playerShouldPauseAction),
            name:Notification.Name( VIDEO_PLAYER_PAUSE),
            object: nil)
        
        var isFirstTime = true
        
        gradeientPatern(yourView: self.blackLayerImageView, firstColor: UIColor.clear.cgColor, secondColor: UIColor.black.cgColor)
        
        self.likeBtn.tag = 0
        self.likeCountLbl.tag = 0
        
         var myuserId = ""
        
        if (self.defaultsHlpr.getfbId().isEmpty != true)  {
            myuserId = self.defaultsHlpr.getfbId()
        }
        else if (self.defaultsHlpr.getId().isEmpty != true)  {
            myuserId = self.defaultsHlpr.getId()
        }
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.forPlayerPaused(_:)), name: NSNotification.Name(rawValue: "forPalyerPausedNoti"), object: nil)
        
        
        
       // UITabBar.appearance().barTintColor = UIColor.clear
        
        self.secondViewLabel.layer.cornerRadius = 20
        self.secondViewLabel.layer.masksToBounds = true
        self.hashtag1.layer.cornerRadius = 10
        self.hashtag1.layer.masksToBounds = true
        self.hashtrag2.layer.cornerRadius = 10
        self.hashtrag2.layer.masksToBounds = true
        self.thirdViewLabel.layer.cornerRadius = 20
        self.thirdViewLabel.layer.masksToBounds = true
        self.imageView.layer.cornerRadius = 25
        self.imageView.layer.masksToBounds = true
        
        UITabBar.appearance().shadowImage = UIImage()
       // UITabBar.appearance().backgroundImage = UIImage()
        //UITabBar.appearance().barTintColor = UIColor.clear
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.purple], for: .selected)
        
        
        
        
        
        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGestureRecognizer(_:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        self.player.view.addGestureRecognizer(tapGestureRecognizer)
        
        let swipeFromRight = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeUp(gesture:)))
        swipeFromRight.direction = UISwipeGestureRecognizer.Direction.up
        self.player.view.addGestureRecognizer(swipeFromRight)
        
        let swipeFromLeft = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeDown(gesture:)))
        swipeFromLeft.direction = UISwipeGestureRecognizer.Direction.down
        self.player.view.addGestureRecognizer(swipeFromLeft)
        
//        self.blackLayerImageView.addGestureRecognizer(swipeFromRight)
//        self.blackLayerImageView.addGestureRecognizer(swipeFromLeft)
        
        
        alertView = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        alertView.view.addSubview(loadingIndicator)
        present(alertView, animated: true, completion: nil)
        
        postCall(url: "http://testingmadesimple.org/training_app/api/service/userVideos", myuserId: myuserId)
        
    }
    
    
    @objc private func playerShouldPauseAction(notification: NSNotification){
        
        DispatchQueue.main.async {
            self.player.pause()
        }
        
    }
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        progressBarNIB.isHidden = false
        
        progressBarNIB.layer.cornerRadius = self.progressBarNIB.frame.size.width/2
        
        if let total = notification.userInfo?["TotalCount"] as? String {
            
            if let actualValue = notification.userInfo?["ActualValue"] as? String{
                progressBarNIB.setCircleStrokeWidth(10)
                
                
                print("\(String(describing: Int(actualValue)))")
                print(String(actualValue))



                 let strArr  =    String(actualValue.split(separator: ".")[0]) + "%"
                
                
                progressBarNIB.setProgressText(strArr)
               
                self.progressBarNIB.progress = CGFloat(Float(actualValue)!/100)
                self.progressBarNIB.setProgressText(strArr)
                
                
                if(strArr == "100%"){
                    self.progressBarNIB.isHidden = true
                }
            }
            
        }
    }

    
    
    @IBAction func CommentsAction(_ sender: Any) {
        
        if (videoId != "" && videoId.isEmpty != true) {
            
            let commentsPage = storyboard?.instantiateViewController(withIdentifier: "commentsViewController") as! commentsViewController
            commentsPage.videoId = self.videoId
            navigationController?.pushViewController(commentsPage, animated: false)
            
        }
        
    }
    
    
    
    
//    func showTimerProgressViaNIB() {
//        progressBarNIB.setCircleStrokeWidth(10)
//        var second: CGFloat = 0
//        progressBarNIB.setProgressText("\(Int(second))")
//        Timer.scheduledTimer(withTimeInterval: 1.0, repeats : true) { [weak self] (timer) in
//            second += 1
//            self?.progressBarNIB.progress = second/100
//            self?.progressBarNIB.setProgressText("\(Int(second))")
//
//            if second == 100 { // restart rotation
//                second = 0
//            }
//        }
//    }
    
    @IBAction func shareAction(_ sender: Any) {
        
       
        if(self.urlsArray.count > 0 )
        {
            self.player.pause()
            
            let someText:String = ""
            let objectsToShare:URL = URL(string: self.urlsArray[self.videoIndex])!
            let sharedObjects:[AnyObject] = [objectsToShare as AnyObject,someText as AnyObject]
            let activityViewController = UIActivityViewController(activityItems : sharedObjects, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            
            activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook,UIActivity.ActivityType.postToTwitter,UIActivity.ActivityType.mail , UIActivity.ActivityType.postToFlickr ]
            
                        activityViewController.completionWithItemsHandler = { activity, success, items, error in
                            if success {
                                // Success handling here
                                
            
                                //DispatchQueue.global(qos: .background).async {
                                    
                                    if(DEFAULT_HELPER.getId().isEmpty != true)
                                    {
                                        if(DEFAULT_HELPER.getId() != ""){
                                            let myUrlDix =  self.myVideosDataArray[self.videoIndex] as [String:Any]
                                            let myvideoId = myUrlDix["id"] as! String
                                            
                                            self.sharePostServiceCall(url: SHARE_VIDEO, videoId: myvideoId, userId: DEFAULT_HELPER.getId())
                                        }
                                        
                                        
                                    }
                                    else if(DEFAULT_HELPER.getfbId().isEmpty != true)
                                    {
                                        if(DEFAULT_HELPER.getfbId() != ""){
                                            let myUrlDix =  self.myVideosDataArray[self.videoIndex] as [String:Any]
                                            let myvideoId = myUrlDix["id"] as! String
                                            
                                            self.sharePostServiceCall(url: SHARE_VIDEO, videoId: myvideoId, userId: DEFAULT_HELPER.getfbId())
                                        }
                                        
                                        
                                    }
                                    else
                                    {
                                        DispatchQueue.main.async {
                                            self.view.makeToast("Not Logged in yet")
                                        }
                                    }
                                    
                                    
                                }
            
                                
            
//                            }
//                            else
//                            {
//
//                                self.view.makeToast("Something went wrong")
//                            }
                        }
            
            self.present(activityViewController, animated: true, completion: nil)
            
            
//            let text = "This is the text...."
//
//            let myWebsite = NSURL(string:self.urlsArray[self.videoIndex])
//
//            // text to share
//            let textUrl = NSURL(string: self.urlsArray[self.videoIndex]) //
//
//            // set up activity view controller
//            let textToShare = [  NSURL(string: self.urlsArray[self.videoIndex]) ] as! [URL]
//
//            let sharedObjects:[AnyObject] = [myWebsite as AnyObject,textToShare as AnyObject]
//
//
//            activityViewController = UIActivityViewController(activityItems: sharedObjects , applicationActivities: nil)
//            activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
//
//            // exclude some activity types from the list (optional)
//            activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook , UIActivity.ActivityType.postToFlickr , UIActivity.ActivityType.postToTwitter  ,UIActivity.ActivityType.copyToPasteboard   ]
//
//            activityViewController.completionWithItemsHandler = { activity, success, items, error in
//                if success {
//                    // Success handling here
//                    self.shareBtn.setImage(UIImage(named: "redHeart"), for: .normal)
//
//
//
//                }
//                else
//                {
//
//                }
//            }
//
//            // present the view controller
//            self.present(activityViewController , animated: true , completion: nil)
        }
        
    }
    
    
    
    @IBAction func abusiveAction(_ sender: Any) {
        let signupPage = storyboard?.instantiateViewController(withIdentifier: "abuseViewController") as! abuseViewController
        navigationController?.pushViewController(signupPage, animated: false)
        
    }
    
    
    
    @IBAction func likeButtonAction(_ sender: UIButton) {
        
        if self.myVideosDataArray.count > 0 {
            self.likeBtn.setImage(UIImage(named: "redHeart"), for: .normal)
            
            print("my video index is",sender.tag)
            
            
            var myUrlDix =  self.myVideosDataArray[sender.tag] as [String:Any]
            
            
            let myLikeStatusNum = myUrlDix["likestatus"] as! String

            if(myLikeStatusNum == "0")
            {
                myUrlDix["likestatus"] = "1"
                self.likeBtn.setImage(UIImage(named: "redHeart"), for: .normal)
            }
            else if(myLikeStatusNum == "1")
            {
                myUrlDix["likestatus"] = "0"
                self.likeBtn.setImage(UIImage(named: "hearts-gray-36"), for: .normal)
            }
            
            self.myVideosDataArray[sender.tag] = myUrlDix
            
            
            let myUrlSt = myUrlDix["id"] as! String
            print(myUrlSt)
            
            LikePostServiceCall(url: "http://testingmadesimple.org/training_app/api/Service/videoLike", videoId: myUrlSt)
        }
        
    }
    
   
    
    
    func postCall(url : String , myuserId : String){
        
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        let postString = "userId=\(myuserId)"
        
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            do {
                
                if let responseJSON = try JSONSerialization.jsonObject(with: data!) as? [String:AnyObject]{
                    print(responseJSON)
                    
                    
                    if(responseJSON["status"] as! Int == 0)
                    {
                        self.view.makeToast("Something Went Wrong")
                    }
                    else if(responseJSON["status"] as! Int == 1)
                        {
                            
   if let myVideos = responseJSON["videos"] as? [[String:Any]] {
                                
                                self.myVideosDataArray = myVideos
                                
                                let serverUrl = responseJSON["url"] as! String
                                
                                if(self.urlsArray.count > 0 )
                                {
                                    self.urlsArray.removeAll()
                                }
                                
                                if(self.videoFromServer.count > 0 )
                                {
                                    self.videoFromServer.removeAll()
                                }
                                
                                
                                
                                for index in 0..<myVideos.count {
                                    
                                    let myUrlDix =  myVideos[index] as [String:Any]
                                    let myUrlSt = myUrlDix["video"] as! String
                                    print(myUrlSt)
                                    let myur = /*serverUrl*/TEMP_VIDEO_URL + myUrlSt
                                    self.urlsArray.append(myur)
                                    self.videoFromServer.append(myUrlSt)
                                }
                                
                                
                                
            DispatchQueue.main.async{
                                    
        if let myName =  responseJSON["userId"] as? String{
                                        
                                        let last4 = String(myName.suffix(4))
                     DispatchQueue.main.async {
                       self.userNameLbl.text = "User" + last4
                       }
                                        
                                        
                                    }
                                    else if  self.defaultsHlpr.getId() != "" {
                                        
                                        let last4 = String(self.defaultsHlpr.getId().suffix(4))
                                        DispatchQueue.main.async {
                                           self.userNameLbl.text = "User" + last4
                                        }
                                        
                                    }
                                    else if   self.defaultsHlpr.getfbId() != ""{
                                        let last4 = String(self.defaultsHlpr.getfbId().suffix(4))
                                        DispatchQueue.main.async {
                                            self.userNameLbl.text = "User" + last4
                                        }
                                    }
                                    else
                                    {
                                        DispatchQueue.main.async {
                                            self.userNameLbl.text = "User Name"
                                        }
                                    }
                                    
                                    if(self.isFirstTime == true && self.myVideosDataArray.count > 0)
                                    {
                                        self.isFirstTime = false
                                        
                                       
                                        
                                        let myUrlDix =  self.myVideosDataArray[0] as [String:Any]
                                        if let myhash = myUrlDix["hashTag"] as? String{
                                            self.hashtag1.setTitle(myhash, for: .normal)
                                            self.hashtag1.isHidden = false
                                        }
                                        else
                                        {
                                            self.hashtag1.setTitle("", for: .normal)
                                        }
                                        let myLikeStatusNum = myUrlDix["likestatus"] as! String
                                        let myLikesCountNum = myUrlDix["likes"] as! String
                                        if let myCommentsCount  = myUrlDix["commentCount"] as? String{
                                            self.commentsCount = myCommentsCount
                                             self.commentsCCountLbl.text = myCommentsCount
        if(Int(myCommentsCount)! > 0)
        {
           if let myComentarray = myUrlDix["comments"] as? [[String:Any]]{
            
               if ((myComentarray.count) > 0){
                   let mycom1 = myComentarray[0]
                     if let mystatement1 = mycom1["comment"] as? String{
                                                            
                         if let commentUSer = mycom1["userId"] as? String{
                            
                            let last4 = String(commentUSer.suffix(4))
                            self.comment1Lbl.text = "@User" + last4 + " : " + mystatement1
                                                            }
                         else{
                               self.comment1Lbl.text = mystatement1
                            
                        }
                        
                     }
                        
                     else{
                        
                        self.comment1Lbl.text = ""
                        
                }
                
            }
                                                    
              if ((myComentarray.count) > 1){
                   let mycom1 = myComentarray[1]
                   if let mystatement1 = mycom1["comment"] as? String{
                    
                    if let commentUSer = mycom1["userId"] as? String{
                        
                        let last4 = String(commentUSer.suffix(4))
                        self.comment1Lb2.text = "@User" + last4 + " : " + mystatement1
                    }
                    else{
                        self.comment1Lb2.text = mystatement1
                        
                    }
                    
                   }
                                    else{
                                        self.comment1Lb2.text = ""
                                        }
                                }
                                                    
                                                    
    }
            
                                                
                }
                  else
                  {
                    self.comment1Lbl.text = ""
                    self.comment1Lb2.text = ""
                  }
                                            
                                            

                                            
                                            
                                        }
                                        self.videoId  = myUrlDix["id"] as! String
                                        
                                        
                                        
                                        
                                        if(myLikeStatusNum == "0")
                                        {
                                            self.likeBtn.setImage(UIImage(named: "hearts-gray-36"), for: .normal)
                                        }
                                        else if(myLikeStatusNum == "1")
                                        {
                                            self.likeBtn.setImage(UIImage(named: "redHeart"), for: .normal)
                                        }
                                        self.likeCountLbl.text = myLikesCountNum
                                    }
                                    
                                    self.player.playerDelegate = self
                                    self.player.playbackDelegate = self
                                    
                                    self.player.playerView.playerBackgroundColor = .black
                                    
                                    self.addChild(self.player)
                                    self.videoView.addSubview(self.player.view)
                                    self.player.didMove(toParent: self)
                                    
                                    if(self.urlsArray.count  > 0)
                                    {
                                        //                                if(self.urlsArray.count - 1 > self.videoIndex )
                                        //                                {
                                        //
                                        //                                }
                                        //                                else
                                        //                                {
                                        videoUrl = URL(string:self.urlsArray[self.videoIndex])
                                        self.player.url = videoUrl
                                        
                                         self.player.playFromBeginning()
                                        self.player.playbackLoops = true
                                        // }
                                        DispatchQueue.main.async {
                                            self.removeLoad()
                                        }
                                        
                                    }
                                    else
                                    {
                                        DispatchQueue.main.async {
                                            self.removeLoad()
                                            self.view.makeToast("No Videos Yet")
                                        }
                                        
                                    }
                                    
                                }
                            }
                            else
                            {
                                DispatchQueue.main.async {
                                    self.removeLoad()
                                    self.view.makeToast("No Videos Yet")
                                }
                            }
                    }
                    else if(responseJSON["status"] as! Int == 2)
                    {
                        DispatchQueue.main.async {
                            self.removeLoad()
                            self.view.makeToast("No Videos Yet")
                        }
                    }
                    
                    
                    
                }
            }
            catch {
                print("Error -> \(error)")

                DispatchQueue.main.async {
                    self.removeLoad()
                    
                }
            }
            
            
            
        }
        
        
        task.resume()
        
        
        
    }
    
    
    
    
    
    
    
    func LikePostServiceCall(url : String , videoId : String){
        
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        let postString = "userId=\("1")&videoId=\(videoId)"
        print(postString)
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            do {
                if let responseJSON = try JSONSerialization.jsonObject(with: data!) as? [String:AnyObject]{
                    print(responseJSON)
                    
                }
            }
            catch {
                print("Error -> \(error)")
            }
            
        }
        
        task.resume()
        
    }
    
    
    
    func sharePostServiceCall(url : String , videoId : String , userId : String){
        
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        let postString = "userId=\(userId)&videoId=\(videoId)"
        print(postString)
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(error?.localizedDescription)")
                return
            }
            
            do {
                if let responseJSON = try JSONSerialization.jsonObject(with: data!) as? [String:AnyObject]{
                    print(responseJSON)
                    if(responseJSON["status"] as! Int == 1)
                    {
                        
                    }
                }
            }
            catch {
                print("Error -> \(error)")
            }
            
        }
        
        task.resume()
        
    }
    
    
    
    @IBAction func profileFollowAction(_ sender: Any) {
        
        if defaultsHlpr.getfbId() != "" {
            
            
            self.followTickBtn.setImage(UIImage(named: "profile-check-36"), for: .normal)
        }
        else if defaultsHlpr.getId() != "" {
            
            
            self.followTickBtn.setImage(UIImage(named: "profile-check-36"), for: .normal)
        }
        else
        {
            let signupPage = storyboard?.instantiateViewController(withIdentifier: "signupVC") as! signupVC
            navigationController?.pushViewController(signupPage, animated: false)
        }
        
        
    }
    
    
    
    
    @objc func forPlayerPaused(_ notification: NSNotification) {
        
        self.player.pause()
        
    }
    
    func showLoad()  {
        alertView = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        alertView.view.addSubview(loadingIndicator)
        present(alertView, animated: true, completion: nil)
    }
    
    func removeLoad()  {
        dismiss(animated: true, completion: nil)
    }
    
    //Swipe gesture selector function
    @objc func didSwipeUp(gesture: UIGestureRecognizer) {
        
        
        DispatchQueue.global(qos: .background).async {
            print("This is run on the background queue")
            self.videoIndex = self.videoIndex + 1
            if self.videoIndex >= self.urlsArray.count {
                self.videoIndex = self.urlsArray.count - 1
            }
            
            if(self.urlsArray.count > self.videoIndex )
            {
                DispatchQueue.main.async {
                    // self.showLoad()
                }
                self.player.fillMode = PlayerFillMode.resizeAspectFill
                videoUrl = URL(string:self.urlsArray[self.videoIndex])
                self.player.url = videoUrl
              
                
                DispatchQueue.main.async {
                     self.likeBtn.tag = self.videoIndex
                    self.likeCountLbl.tag = self.videoIndex
                    let myUrlDix =  self.myVideosDataArray[self.videoIndex] as [String:Any]
                    let myLikeStatusNum = myUrlDix["likestatus"] as! String
                    let myLikesCountNum = myUrlDix["likes"] as! String
                    if let myCommentsCount  = myUrlDix["commentCount"] as? String{
                        self.commentsCount = myCommentsCount
                        self.commentsCCountLbl.text = myCommentsCount
                        if(Int(myCommentsCount)! > 0)
                        {
                            let myComentDic = myUrlDix["comments"] as? [[String:Any]]
                            if let mylatestCommentdic = myComentDic?[0]{
                                self.comment1Lbl.text = mylatestCommentdic["comment"] as? String
                                self.comment1Lbl.adjustsFontSizeToFitWidth = true
                                self.comment1Lbl.text = "User " + self.comment1Lbl.text!
                                self.myMutableString = NSMutableAttributedString(string: self.comment1Lbl.text!, attributes: [NSAttributedString.Key.font:UIFont(name: "HelveticaNeue-Bold", size: 12.0)!])
                                self.myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location:0,length:4))
                                // set label Attribute
                                self.comment1Lbl.attributedText = self.myMutableString
                            }
                            
                            
                            
                            
                            
                            if let myComentarray = myUrlDix["comments"] as? [[String:Any]]{
                                
                                if ((myComentarray.count) > 0){
                                    let mycom1 = myComentarray[0]
                                    if let mystatement1 = mycom1["comment"] as? String{
                                        
                                        if let commentUSer = mycom1["userId"] as? String{
                                            
                                            let last4 = String(commentUSer.suffix(4))
                                            self.comment1Lbl.text = "@User" + last4 + " : " + mystatement1
                                        }
                                        else{
                                            self.comment1Lbl.text = mystatement1
                                            
                                        }
                                        
                                    }
                                        
                                    else{
                                        
                                        self.comment1Lbl.text = ""
                                        
                                    }
                                    
                                }
                                
                                if ((myComentarray.count) > 1){
                                    let mycom1 = myComentarray[1]
                                    if let mystatement1 = mycom1["comment"] as? String{
                                        
                                        if let commentUSer = mycom1["userId"] as? String{
                                            
                                            let last4 = String(commentUSer.suffix(4))
                                            self.comment1Lb2.text = "@User" + last4 + " : " + mystatement1
                                        }
                                        else{
                                            self.comment1Lb2.text = mystatement1
                                            
                                        }
                                        
                                    }
                                    else{
                                        self.comment1Lb2.text = ""
                                    }
                                }
                                
                                
                            }
                            
                            
                            
                            
                            
                        }
                        else
                        {
                            self.comment1Lbl.text = ""
                        }
                    }
                    if let myshareCount  = myUrlDix["shareCount"] as? String{
                        
                        self.shareCountLbl.text = myshareCount
                    }
                    self.videoId  = myUrlDix["id"] as! String
                    if(myLikeStatusNum == "0")
                    {
                        self.likeBtn.setImage(UIImage(named: "hearts-gray-36"), for: .normal)
                    }
                    else if(myLikeStatusNum == "1")
                    {
                         self.likeBtn.setImage(UIImage(named: "redHeart"), for: .normal)
                    }
                    
                    
                    self.likeCountLbl.text = myLikesCountNum
                    
                    print("This is run on the main queue, after the previous code in outer block")
                    self.player.playFromBeginning()
                }
                
            }
            
            
        }
        
        
    }
    
    //Swipe gesture selector function
    @objc func didSwipeDown(gesture: UIGestureRecognizer) {
        // Add animation here
        
        DispatchQueue.global(qos: .background).async {
            print("This is run on the background queue")
            
            if(self.urlsArray.count > self.videoIndex )
            {
                if(self.videoIndex == 0)
                {
                    self.videoIndex = 0
                }else{
                    self.videoIndex = self.videoIndex - 1
                }
                
                videoUrl = URL(string:self.urlsArray[self.videoIndex])
                self.player.url = videoUrl
                
                
                DispatchQueue.main.async {
                    self.likeBtn.tag = self.videoIndex
                    self.likeCountLbl.tag = self.videoIndex
                    
                    let myUrlDix =  self.myVideosDataArray[self.videoIndex] as [String:Any]
                    let myLikeStatusNum = myUrlDix["likestatus"] as! String
                    let myLikesCountNum = myUrlDix["likes"] as! String
                    if let myCommentsCount  = myUrlDix["commentCount"] as? String{
                        self.commentsCount = myCommentsCount
                        self.commentsCCountLbl.text = myCommentsCount
                        if(Int(myCommentsCount)! > 0)
                        {
                            let myComentDic = myUrlDix["comments"] as? [[String:Any]]
                            if let mylatestCommentdic = myComentDic?[0]{
                                self.comment1Lbl.text = mylatestCommentdic["comment"] as? String
                                self.comment1Lbl.adjustsFontSizeToFitWidth = true
                                self.comment1Lbl.text = "User " + self.comment1Lbl.text!
                                self.myMutableString = NSMutableAttributedString(string: self.comment1Lbl.text!, attributes: [NSAttributedString.Key.font:UIFont(name: "HelveticaNeue-Bold", size: 12.0)!])
                                self.myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location:0,length:4))
                                // set label Attribute
                                self.comment1Lbl.attributedText = self.myMutableString
                            }
                            
                        }
                        else
                        {
                            self.comment1Lbl.text = ""
                        }
                        
                        
                        if let myComentarray = myUrlDix["comments"] as? [[String:Any]]{
                            
                            if ((myComentarray.count) > 0){
                                let mycom1 = myComentarray[0]
                                if let mystatement1 = mycom1["comment"] as? String{
                                    
                                    if let commentUSer = mycom1["userId"] as? String{
                                        
                                        let last4 = String(commentUSer.suffix(4))
                                        DispatchQueue.main.async {
                                            self.comment1Lbl.text = "@User" + last4 + " : " + mystatement1
                                        }
                                        
                                    }
                                    else{
                                        DispatchQueue.main.async {
                                            self.comment1Lbl.text = mystatement1
                                        }
                                        
                                    }
                                    
                                }
                                    
                                else{
                                    DispatchQueue.main.async {
                                        self.comment1Lbl.text = ""
                                    }
                                    
                                }
                                
                            }
                            
                            if ((myComentarray.count) > 1){
                                let mycom1 = myComentarray[1]
                                if let mystatement1 = mycom1["comment"] as? String{
                                    
                                    if let commentUSer = mycom1["userId"] as? String{
                                        
                                        let last4 = String(commentUSer.suffix(4))
                                        DispatchQueue.main.async {
                                        self.comment1Lb2.text = "@User" + last4 + " : " + mystatement1
                                        }
                                    }
                                    else{
                                        DispatchQueue.main.async {
                                        self.comment1Lb2.text = mystatement1
                                        }
                                    }
                                    
                                }
                                else{
                                    DispatchQueue.main.async {
                                    self.comment1Lb2.text = ""
                                    }
                                }
                            }
                            
                            
                        }
                        
                        
                        
                    }
                    
                    if let myshareCount  = myUrlDix["shareCount"] as? String{
                        DispatchQueue.main.async {
                        self.shareCountLbl.text = myshareCount
                        }
                    }
                    
                    self.videoId  = myUrlDix["id"] as! String
                    if(myLikeStatusNum == "0")
                    {
                        DispatchQueue.main.async {
                        self.likeBtn.setImage(UIImage(named: "hearts-gray-36"), for: .normal)
                        }
                    }
                    else if(myLikeStatusNum == "1")
                    {
                        DispatchQueue.main.async {
                        self.likeBtn.setImage(UIImage(named: "redHeart"), for: .normal)
                        }
                    }
                    DispatchQueue.main.async {
                     self.likeCountLbl.text = myLikesCountNum
                    print("This is run on the main queue, after the previous code in outer block")
                    self.player.playFromBeginning()
                    }
                }
                
                
            }
            else if(self.urlsArray.count < self.videoIndex){
                self.videoIndex = self.urlsArray.count - 1
                videoUrl = URL(string:self.urlsArray[self.videoIndex])
                self.player.url = videoUrl
                
                DispatchQueue.main.async {
                    print("This is run on the main queue, after the previous code in outer block")
                    self.player.playFromBeginning()
                }
            }
            print("my index",self.videoIndex )
            
            
        }
        
        DispatchQueue.main.async(execute: {
            //            if(self.urlsArray.count > self.videoIndex && self.videoIndex != 0)
            //            {
            //                self.videoIndex = self.videoIndex - 1
            //                videoUrl = URL(string:self.urlsArray[self.videoIndex])
            //                self.player.url = videoUrl
            //
            //                self.player.playFromBeginning()
            //            }
            //            else if(self.urlsArray.count < self.videoIndex){
            //               self.videoIndex = self.urlsArray.count - 1
            //                videoUrl = URL(string:self.urlsArray[self.videoIndex])
            //                self.player.url = videoUrl
            //
            //                self.player.playFromBeginning()
            //            }
            //            print("my index",self.videoIndex )
        })
    }
    
    //MARK: View Life Cycle methods
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.player.playFromBeginning()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        var myuserId = ""
        
        if (self.defaultsHlpr.getfbId().isEmpty != true)  {
            myuserId = self.defaultsHlpr.getfbId()
        }
        else if (self.defaultsHlpr.getId().isEmpty != true)  {
            myuserId = self.defaultsHlpr.getId()
        }
        
        
       // if ( myuserId != "" && myuserId.isEmpty != true ) {
             postCall(url: "http://testingmadesimple.org/training_app/api/service/userVideos", myuserId: myuserId)
           
//        }
//        else
//        {
//            self.view.makeToast("Server Error")
//        }
        
        self.player.playbackResumesWhenBecameActive = false
        //self.player.playbackResumesWhenEnteringForeground = false
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
        //UITabBar.appearance().backgroundColor = UIColor.clear
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "middleButton"), object: nil, userInfo: nil)
       // UITabBar.appearance().barTintColor = UIColor.clear
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        self.player.playbackResumesWhenBecameActive = false
        self.player.playbackResumesWhenEnteringForeground = false
        self.navigationController?.navigationBar.isHidden = false
        
    }
    
    
}

// MARK: - UIGestureRecognizer

extension ViewController {
    
    @objc func handleTapGestureRecognizer(_ gestureRecognizer: UITapGestureRecognizer) {
        switch (self.player.playbackState.rawValue) {
        case PlaybackState.stopped.rawValue:
            self.player.playFromBeginning()
            print("play from begining")
            break
        case PlaybackState.paused.rawValue:
            self.player.playFromCurrentTime()
            print("play from current time")
            break
        case PlaybackState.playing.rawValue:
            self.player.pause()
            
            break
        case PlaybackState.failed.rawValue:
            self.player.pause()
            break
        default:
            self.player.pause()
            break
        }
    }
    
}

// MARK: - PlayerDelegate

extension ViewController: PlayerDelegate {
    
    func playerReady(_ player: Player) {
        print("\(#function) ready")
    }
    
    func playerPlaybackStateDidChange(_ player: Player) {
        print("\(#function) \(player.playbackState.description)")
        if player.playbackState.description == "Paused" {
            self.playImg.isHidden = false
            
        }
        else
        {
            self.playImg.isHidden = true
            
        }
    }
    
    func playerBufferingStateDidChange(_ player: Player) {
        if (player.bufferingState == .delayed) {
            //dismiss(animated: true, completion: nil)
        }
        else if (player.bufferingState == .ready) {
            
        }
        else if (player.bufferingState == .unknown) {
            //dismiss(animated: true, completion: nil)
        }
    }
    
    func playerBufferTimeDidChange(_ bufferTime: Double) {
        
    }
    
    func player(_ player: Player, didFailWithError error: Error?) {
        print("\(#function) error.description" , error?.localizedDescription ?? "error came")
        
    }
    
}

// MARK: - PlayerPlaybackDelegate

extension ViewController: PlayerPlaybackDelegate {
    
    func playerCurrentTimeDidChange(_ player: Player) {
        
        let fraction = Double(player.currentTime) / Double(player.maximumDuration)
        
        if(player.playbackState == .playing)
        {
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    func playerPlaybackWillStartFromBeginning(_ player: Player) {
    }
    
    func playerPlaybackDidEnd(_ player: Player) {
    }
    
    func playerPlaybackWillLoop(_ player: Player) {
    }
    
}

