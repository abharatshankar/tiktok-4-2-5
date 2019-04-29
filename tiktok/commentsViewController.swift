//
//  commentsViewController.swift
//  tiktok
//
//  Created by Bharat shankar on 10/04/19.
//  Copyright © 2019 Bharat shankar. All rights reserved.
//

import UIKit
import Toast_Swift


class commentsViewController: UIViewController  , UITableViewDelegate , UITableViewDataSource{
    
    @IBOutlet weak var sendBtn: UIButton!
    
    @IBOutlet weak var commentTxt: UITextField!
    
    @IBOutlet weak var myCommentsTbl: UITableView!
    var videoId = ""
    var myDataArray = [[String:Any]]()
    var myParentId = ""
    var myParentIdArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //to hide middle camera button
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "MiddlebTnHide"), object: nil, userInfo: nil)
        
        // to set theme color of navigationbar
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.5529411765, green: 0, blue: 0.968627451, alpha: 1)
        
        shadowView(view: self.commentTxt)
        shadowView(view: self.sendBtn)
        
        self.commentTxt.layer.cornerRadius = 15
        self.sendBtn.layer.cornerRadius = 15
        self.title = "All Comments"
        
        
        
        if self.videoId != ""
        {
            APICall(myVideoId: self.videoId)
        }
        else
        {
            self.view.makeToast("Something went wrong")
        }
        
        
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationItem.hidesBackButton = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    @IBAction func sendBtnAction(_ sender: Any) {
        
        
        let commentTxt = String(self.commentTxt.text!.filter { !"\n".contains($0) })
        
        if commentTxt == "" {
            self.view.makeToast("Please enter text")
            return
        }
        
        
        if self.videoId == "" || self.videoId.isEmpty == true
        {
            self.view.makeToast("Something Went Wrong")
            return
        }
        
        if  DEFAULT_HELPER.getId().isEmpty != true
        {
            if DEFAULT_HELPER.getId() != ""{
                CommentPostServiceCall(userId: DEFAULT_HELPER.getId(), videoId: self.videoId, mycomment: commentTxt, parentId: myParentId, url: SEND_COMMENT+self.videoId)
            }
            
        }
        else if  DEFAULT_HELPER.getfbId().isEmpty != true
        {
            if DEFAULT_HELPER.getfbId() != ""{
                CommentPostServiceCall(userId: DEFAULT_HELPER.getfbId(), videoId: self.videoId, mycomment: commentTxt, parentId: myParentId, url: SEND_COMMENT)
            }
            
        }
        else{
            self.view.makeToast("Something Went Wrong")
            return
        }
        
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.myDataArray.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        do {
            let mydict =  try self.myDataArray[indexPath.row]
            
            if mydict.keys.contains("parentId") {
                // contains key
                let cell = tableView.dequeueReusableCell(withIdentifier: "commentReplyTableViewCell", for: indexPath) as! commentReplyTableViewCell
                cell.selectionStyle = .none
                
                cell.likeBtn.tag = indexPath.row
                cell.likeBtn.isHidden = true
                cell.likeBtn.addTarget(self, action: #selector(likeSelected(sender:)), for: UIControl.Event.touchUpInside)
                
                cell.userImage.layer.cornerRadius = cell.userImage.frame.size.width/2
                
                cell.userImage.layer.masksToBounds = true
                
                if let validateUId = mydict["userId"] as? [String : String]  {
                    
                    if(validateUId["_id"] as! String == DEFAULT_HELPER.getId()){
                        cell.replyBtn.isHidden = true
                    }
                    else if(validateUId["_id"] as! String  == DEFAULT_HELPER.getfbId()){
                        cell.replyBtn.isHidden = true
                    }else{
                        cell.replyBtn.isHidden = true
                    }
                    
                    
                }
                
                
                
                
                if let myLikesCount = mydict["likeCount"] as? String{
                    cell.likesCountLbl.text = myLikesCount
                }else if let myLikesCount = mydict["likeCount"] as? Int{
                    cell.likesCountLbl.text = String(myLikesCount)
                }
                
                if let myuserDict = mydict["userId"] as? [String:Any]{
                    
                    if let myid = myuserDict["_id"] as? String{
                        
                        let last4 = String(myid.suffix(4))
                        cell.userNameLbl.text = "@User"+last4
                    }
                    
                }
                
                if let myuserComment = mydict["comment"] as? String
                {
                    cell.commentReplyLbl.text = myuserComment
                }
                
                
                if let myuserReplyDict = mydict["parentId"] as? [String:Any]{
                    if let myCommentIdDict = myuserReplyDict["commentId"] as? [String:Any]{
                        
                        if let myComment = myCommentIdDict["comment"] as? String{
                            cell.commentLbl.text = myComment
                        }
                        
                    }
                }
                
                
                return cell
                
                
            } else {
                // does not contain key
                let cell = tableView.dequeueReusableCell(withIdentifier: "commentTableViewCell", for: indexPath) as! commentTableViewCell
                cell.selectionStyle = .none
                cell.likeBtn.tag = indexPath.row
                cell.likeBtn.isHidden = true
                
                cell.userImage.layer.cornerRadius = cell.userImage.frame.size.width/2
                
                cell.userImage.layer.masksToBounds = true
                
                if let myLikesCount = mydict["likeCount"] as? String{
                    cell.likesCountLbl.text = myLikesCount
                }else if let myLikesCount = mydict["likeCount"] as? Int{
                    cell.likesCountLbl.text = String(myLikesCount)
                }
                
                if let myuserDict = mydict["userId"] as? [String:Any]{
                    
                    if let myid = myuserDict["_id"] as? String{
                        
                        let last4 = String(myid.suffix(4))
                        cell.userNameLbl.text = "@User"+last4
                    }
                    
                }
                
                
                if let validateUId = mydict["userId"] as? [String : String]  {
                    
                    if(validateUId["_id"] == DEFAULT_HELPER.getId()){
                        cell.replyBtn.isHidden = true
                    }
                    else if(validateUId["_id"]   == DEFAULT_HELPER.getfbId()){
                        cell.replyBtn.isHidden = true
                    }else{
                        cell.replyBtn.isHidden = true
                    }
                    
                    
                }
                
                
                if let myuserComment = mydict["comment"] as? String
                {
                    cell.commentLbl.text = myuserComment
                }
                
                
                return cell
                
            }
            
        } catch let error as NSError{
            
            print(error)
            
        }
        
        // let mydict = self.myDataArray[indexPath.row]
        
        
        
        
        
    }
    
    
    @objc func likeSelected(sender: UIButton){
        
        if(self.myDataArray.count > 0){
            
            
            if(self.myParentIdArray.count > 0){
                if  self.myParentIdArray[sender.tag].isEmpty != true {
                    if(DEFAULT_HELPER.getId() != "" )
                    {
                        likeServiceCall(url: COMMENT_LIKE+self.myParentIdArray[sender.tag], myuserId: DEFAULT_HELPER.getId() )
                    }else if(DEFAULT_HELPER.getfbId() != "")
                    {
                        likeServiceCall(url: COMMENT_LIKE+self.myParentIdArray[sender.tag], myuserId: DEFAULT_HELPER.getfbId() )
                    }
                }
            }
            
            
        }
        
    }
    
    
    
    
    
    func likeServiceCall(url : String , myuserId : String){
        
        //loader
        showLoading(view: self.view)
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        let postString = "userId=\(myuserId)"
        
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(error)")
                return
                    DispatchQueue.main.async{
                        
                        //hide loader
                        hideLoading(view: self.view)
                }
            }
            
            
            
            do {
                
                DispatchQueue.main.async{
                    
                    //hide loader
                    hideLoading(view: self.view)
                }
                
                if let responseJSON = try JSONSerialization.jsonObject(with: data!) as? [String:AnyObject]{
                    print(responseJSON)
                    
                    //status 0
                    if responseJSON["success"]!.stringValue == "0"
                    {
                        self.view.makeToast("Please Provide Required Data")
                        
                    }
                        //status 1
                    else if(responseJSON["success"]!.stringValue == "1")
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
    
    
    
    
    
    
    
    ///////////////////////////////////
    ///get method
    //////////////////////////////////
    func APICall(myVideoId : String){
        
        //loader
        showLoading(view: self.view)
        
        let url = URL(string: "http://68.183.81.213:4200/api/v1/comments/"+myVideoId )!
        
        URLSession.shared.dataTask(with: url, completionHandler: {
            
            (data, response, error) in
            
            if(error != nil){
                
                print("error")
                
                DispatchQueue.main.async{
                    
                    hideLoading(view: self.view)
                    
                }
                
            }else{
                
                do{
                    DispatchQueue.main.async{
                        
                        //hide loader
                        hideLoading(view: self.view)
                        
                    }
                    
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! NSDictionary
                    
                    print(json)
                    
                    if let myData = json["data"] as? [[String:Any]]
                    {
                        
                        self.myDataArray = myData.reversed()
                    }
                    
                    
                    //main thread
                    DispatchQueue.main.async{
                        if(self.myParentIdArray.count>0)
                        {
                            self.myParentIdArray.removeAll()
                        }
                        
                        for i in 0..<self.myDataArray.count{
                            do{
                                let mydict =  try self.myDataArray[i]
                                
                                if mydict.keys.contains("parentId") {
                                    // contains key
                                    let myPdic = mydict["parentId"] as? [String:Any]
                                    
                                    if let myInternalDic = myPdic!["commentId"] as? [String:String]
                                    {
                                        let myDesiredComentId = myInternalDic["_id"]
                                        self.myParentIdArray.append(myDesiredComentId!)
                                    }
                                    
                                    
                                }
                                else{
                                    self.myParentIdArray.append("")
                                }
                            } catch let error as NSError{
                                
                                print(error)
                                
                            }
                        }
                        
                        if(self.myDataArray.count > 0)
                        {
                            self.myCommentsTbl.scrollToBottom()
                        }
                        
                        self.myCommentsTbl.reloadData()
                        
                    }
                    
                    
                    
                }catch let error as NSError{
                    
                    print(error)
                    
                }
            }
            
        }).resume()
        
        
        
    }
    
    
    
    //    {
    //    "userId": "string",
    //    "videoId": "string",
    //    "comment": "string",
    //    "parentId": "string"
    //    }
    
    
    func jsonString(dictionary : [String:String]) -> String {
        if let theJSONData = try? JSONSerialization.data(
            withJSONObject: dictionary,
            options: []) {
            let theJSONText = String(data: theJSONData,
                                     encoding: .ascii)
            print("JSON string = \(theJSONText!)")
            return theJSONText!
        }
        else
        {
            return ""
        }
    }
    
    func CommentPostServiceCall(userId : String , videoId : String ,mycomment : String , parentId : String , url: String){
        
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        
        
        let mySendDict:[String:String] = ["userId":userId, "videoId":videoId, "comment":mycomment , "parentId":parentId]
        
        
        
        let postString = self.jsonString(dictionary: mySendDict)
        // let postString = "userId=\(userId)&videoId=\(videoId)&comment=\(comment)&parentId=\(parentId)"
        print(postString)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            do {
                if let responseJSON = try JSONSerialization.jsonObject(with: data!) as? [String:AnyObject]{
                    print(responseJSON)
                    
                    if (responseJSON.keys.contains("data")){
                        if responseJSON["data"] != nil
                        {
                            let mydic = responseJSON["data"] as! [String:Any]
                            self.myDataArray.append(mydic)
                            DispatchQueue.main.async{
                                
                                self.myCommentsTbl.scrollToBottom()
                                self.myCommentsTbl.reloadData()
                                
                            }
                        }
                    }
                    
                }
            }
            catch {
                print("Error -> \(error)")
            }
            
        }
        
        task.resume()
        
    }
    
    
    
    
    
}

extension UITableView {
    
    func scrollToBottom(){
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(
                row: self.numberOfRows(inSection:  self.numberOfSections - 1) - 1,
                section: self.numberOfSections - 1)
            self.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    func scrollToTop() {
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            self.scrollToRow(at: indexPath, at: .top, animated: false)
        }
    }
}
