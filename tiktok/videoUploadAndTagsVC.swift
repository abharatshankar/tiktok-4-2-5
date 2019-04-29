//
//  videoUploadAndTagsVC.swift
//  tiktok
//
//  Created by Bharat shankar on 12/04/19.
//  Copyright © 2019 Bharat shankar. All rights reserved.
//

import UIKit
import Alamofire
import Toast_Swift
import AVKit

var myRecordedThumbNail = UIImage()


class videoUploadAndTagsVC: UIViewController , UITextViewDelegate{

    
    @IBOutlet weak var saveBtn: UIButton!
    
    @IBOutlet weak var videoThumbNailImage: UIImageView!
    
    @IBOutlet weak var hashTagsTextView: UITextView!
    
    @IBOutlet weak var commentSwitch: UISwitch!
    
    var hashTagsStr = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.videoThumbNailImage.image = myRecordedThumbNail

        self.saveBtn.layer.borderColor = #colorLiteral(red: 0.4392156863, green: 0, blue: 0.768627451, alpha: 1)
        self.saveBtn.layer.borderWidth = 1
        
        self.hashTagsTextView.delegate = self
        self.hashTagsTextView.text = "Add your hash tags with #"
        self.hashTagsTextView.textColor = UIColor.lightGray
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        self.videoThumbNailImage.isUserInteractionEnabled = true
        self.videoThumbNailImage.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "videoPreviewPlayVC") as! videoPreviewPlayVC
        storyboard.myVideoUrl = videoUrl2
        self.present(storyboard, animated: true, completion: nil)
        
        // Your action
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if self.hashTagsTextView.textColor == UIColor.lightGray {
            self.hashTagsTextView.text = ""
            self.hashTagsTextView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if self.hashTagsTextView.text == "" {
            
            self.hashTagsTextView.text = "Add your hash tags with #"
            self.hashTagsTextView.textColor = UIColor.lightGray
        }
    }
    
    @IBAction func inviteFriendsAction(_ sender: Any) {
    }
    
    
    @IBAction func myHashTagsAction(_ sender: Any) {
        
    }
    
    @IBAction func postVideoAction(_ sender: Any) {
        
        var myId = ""
        
        if defaultsHelper.getfbId().isEmpty != true {
            myId = defaultsHelper.getfbId()
        }
        else if defaultsHelper.getId().isEmpty != true {
            myId = defaultsHelper.getId()
        }
        else
        {
            self.view.makeToast("Please sign up")
            return
        }
        
        if(self.hashTagsTextView.text.isEmpty != true){
            self.hashTagsStr = self.hashTagsTextView.text
        }
        else{
            self.hashTagsStr = ""
        }
        
        
        
                if myId != "" && myId.isEmpty != true {
                    if let myUrl = videoUrl2
                    {
                        videoPostToServer(videoUrl: myUrl , MyuserId : myId)
                    }
                    else
                    {
                        self.view.makeToast("Video not save properly")
                    }
                }
                else
                {
                    self.view.makeToast("please signup first")
                    return
                }
        
    }
    
    
    
    
    
    
    
    
    
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    //MARK:- Video upload service call
    
    func videoPostToServer(videoUrl : URL , MyuserId : String)  {
        // showLoading(view: self.view)
        let myVidoe = String(describing: videoUrl)
        let theFileName = (myVidoe as NSString).lastPathComponent
        print(theFileName)
        
        var myuserid = ""
        if defaultsHelper.getId().isEmpty != true {
            myuserid = defaultsHelper.getId()
        }
        else if defaultsHelper.getfbId().isEmpty != true {
            myuserid = defaultsHelper.getfbId()
        }
        else
        {
            self.view.makeToast("Sign up to Post video")
            return
        }
        
        //        if self.defaultsHelper.getId().isEmpty != true {
        //            myuserid = self.defaultsHelper.getId()
        //        }
        let userIDdata = myuserid.data(using: .utf8, allowLossyConversion: true)
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(videoUrl, withName: "video")
            multipartFormData.append(userIDdata!, withName: "userId")
        }, to:VIDEO_UPLOAD_URL_FIRST )
        { (result) in
            switch result {
            case .success(let upload, _ , _):
                upload.uploadProgress(closure: { (progress) in
                    // print(progress)
                    let imageDataDict:[String: String] = ["TotalCount": String(progress.totalUnitCount * 100) , "ActualValue" : String(progress.fractionCompleted * 100) ]
                    
                    print(progress.totalUnitCount)
                    NotificationCenter.default.post(name: Notification.Name(PROGRESS_BAR_NOTIFICATION), object: nil , userInfo :imageDataDict )
                    
                    print(progress.fractionCompleted)
                })
                upload.responseJSON { response in
                    print(response)
                    print("done")
                    
                   
                        switch response.result {
                        case .success:
                            if let JSON = response.result.value as? [String: Any] {
                                //let message = JSON["message"] as! String
                                //print(message)
                                
                                if let myVideoUploadResponse = JSON["data"] as? [String:Any]{
                                    if let myVideoId = myVideoUploadResponse["_id"] as? String{
                                        var thisSongId = ""
                                        if let mySongId = myVideoUploadResponse["songId"] as? String{
                                            showLoading(view: self.view)
                                            thisSongId = mySongId
                                        }
                                        
                                        
                                        self.videoPostServiceCall(userId: MyuserId, videoId: myVideoId, songId: thisSongId, hashtags: "", url: VIDEO_UPLOAD_AFTER_RESPONSE)
                                    }
                                }
                                
//                                if let myVideoId = JSON["data"] as? String{
//                                    var thisSongId = ""
//                                    if let mySongId = JSON["songId"] as? String{
//                                        showLoading(view: self.view)
//                                        thisSongId = mySongId
//                                    }
//
//
//                                    self.videoPostServiceCall(userId: MyuserId, videoId: myVideoId, songId: thisSongId, hashtags: "", url: VIDEO_UPLOAD_AFTER_RESPONSE)
//                                }
                                
                                
                            }
                        case .failure(let error):
                            print(error)
                            
                            self.view.makeToast("Video Failed to upload")
                            break
                        }
                    
                    
                    
                    //hideLoading(view: self.view)
                }
            case .failure(let encodingError):
                print("failed")
                print(encodingError)
                // hideLoading(view: self.view)
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func videoPostServiceCall(userId : String , videoId : String ,songId : String , hashtags : String , url: String){
        
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        
        
        //let mySendDict:[String:String] = ["userId":userId, "videoId":videoId, "comment":mycomment , "parentId":parentId]
        
         let postString = "userId=\(userId)&videoId=\(videoId)&songId=\(songId)&hashtags=\(hashtags)"
        print(postString)
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                hideLoading(view: self.view)
                
                print("error=\(error)")
                return
            }
            
            do {
                if let responseJSON = try JSONSerialization.jsonObject(with: data!) as? [String:AnyObject]{
                    print(responseJSON)
                    hideLoading(view: self.view)
                    
                    if (responseJSON.keys.contains("data")){
                        if responseJSON["data"] != nil
                        {
                            
                        }
                    }
                    
                }
            }
            catch {
                hideLoading(view: self.view)
                print("Error -> \(error)")
            }
            
        }
        
        task.resume()
        
    }
    
    //MARK:- TextView Delegate
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        //100 chars restriction
        
        return textView.text.count + (text.count - range.length) <= 100
    }
    

}
