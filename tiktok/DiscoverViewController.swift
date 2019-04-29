//
//  DiscoverViewController.swift
//  tiktok
//
//  Created by Bharat shankar on 14/04/19.
//  Copyright © 2019 Bharat shankar. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout, UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var collectionViw: UICollectionView!
    
    @IBOutlet weak var middleView: UIView!
    
    @IBOutlet weak var heightView: NSLayoutConstraint!
    
    @IBOutlet weak var categoriesTbl: UITableView!
    
    @IBOutlet weak var scrolview: UIScrollView!
    
    @IBOutlet weak var myView: UIView!
    
    
    var totalDataArray = [[String:Any]]()
    
    var eachCollectionArray = [[String:Any]]()
    

    var withdataArray = [String]()
    
    var withoutDataArray = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(self.songSelectFunc(notification:)), name: NSNotification.Name(rawValue: "mySelectedVideo"), object: nil)

        self.categoriesTbl.estimatedRowHeight = 210
        self.categoriesTbl.rowHeight = UITableView.automaticDimension
        
        
        DispatchQueue.global(qos: .background).async {
            if(Reachability.isConnectedToNetwork() == true)
            {
                
                if(DEFAULT_HELPER.getId() != "")
                {
                    if(DEFAULT_HELPER.getId().isEmpty == true)
                    {
                        self.view.makeToast("Not registered Yet")
                    }else
                    {
                        DispatchQueue.main.async {
                            showLoading(view: self.view)
                        }
                        self.profilePostCall(url: DISCOVER_PAGE, myuserId: DEFAULT_HELPER.getId())
                    }
                    
                }
                else if(DEFAULT_HELPER.getfbId() != "")
                {
                    if(DEFAULT_HELPER.getfbId().isEmpty == true)
                    {
                        self.view.makeToast("Not registered Yet")
                    }else
                    {
                        DispatchQueue.main.async {
                            showLoading(view: self.view)
                        }
                        self.profilePostCall(url: DISCOVER_PAGE, myuserId: DEFAULT_HELPER.getfbId())
                    }
                    
                }
                
            }
            else
            {
                self.view.makeToast("Check your Connection")
            }
            
            
        }
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.global(qos: .background).async {
            if(Reachability.isConnectedToNetwork() == true)
            {
                
                if(DEFAULT_HELPER.getId() != "")
                {
                    if(DEFAULT_HELPER.getId().isEmpty == true)
                    {
                        self.view.makeToast("Not registered Yet")
                    }else
                    {
                        DispatchQueue.main.async {
                            showLoading(view: self.view)
                        }
                        self.profilePostCall(url: DISCOVER_PAGE, myuserId: DEFAULT_HELPER.getId())
                    }
                    
                }
                else if(DEFAULT_HELPER.getfbId() != "")
                {
                    if(DEFAULT_HELPER.getfbId().isEmpty == true)
                    {
                        self.view.makeToast("Not registered Yet")
                    }else
                    {
                        DispatchQueue.main.async {
                            showLoading(view: self.view)
                        }
                        self.profilePostCall(url: DISCOVER_PAGE, myuserId: DEFAULT_HELPER.getfbId())
                    }
                    
                }
                
            }
            else
            {
                self.view.makeToast("Check your Connection")
            }
            
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        

    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
     {
        return 10
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    
     {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstCollectionViewCell", for: indexPath) as! FirstCollectionViewCell
        
        
        
//        let gifURL : String = "https://upload.wikimedia.org/wikipedia/commons/2/2c/Rotating_earth_%28large%29.gif"
//        let imageURL = UIImage.gifImageWithURL(gifURL)
//
//        cell.firstImage.image = imageURL
        
        
        return cell
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.totalDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let mydict = self.totalDataArray[indexPath.row]
        
        let myVideosAr = mydict["videos"] as? [[String:Any]]
        
        if(myVideosAr!.count > 0){
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingCell", for: indexPath)  as! TrendingCell
            
            
                cell.selectionStyle = .none
                
                cell.viewAllAction.tag = indexPath.row
                
                cell.viewAllAction.addTarget(self, action: #selector(self.viewAllActionFunc(sender:)), for: UIControl.Event.touchUpInside)
                
                let myDictToSend = self.totalDataArray[indexPath.row]
                
                cell.rawDict = myDictToSend
                
                cell.trendingCollection.tag = indexPath.row
                
                let myArr = myDictToSend["videos"] as! [[String:Any]]
                
                cell.myArrayData = myArr
                
                cell.hashTagNameLbl.layer.cornerRadius = 5
                cell.hashTagNameLbl.layer.masksToBounds = true
                shadowView(view: cell.myRoundView)
                
                
                if(myDictToSend.keys.contains("hashTag")){
                    if let myHashName  = myDictToSend["hashTag"] as? String{
                        if(myHashName != ""){
                            cell.hashTagNameLbl.text = myHashName
                            cell.hashTagNameLbl.backgroundColor = UIColor.purple
                        }
                        else
                        {
                            cell.hashTagNameLbl.text = ""
                            cell.hashTagNameLbl.backgroundColor = UIColor.white
                        }
                        
                    }
                    else
                    {
                        cell.hashTagNameLbl.text = ""
                        cell.hashTagNameLbl.backgroundColor = UIColor.white
                    }
                }
            
            
            return cell
        }else
        {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "trendingTableCell2", for: indexPath)  as! trendingTableCell2
            
            
            
            cell.selectionStyle = .none
            
            let myDictToSend = self.totalDataArray[indexPath.row]
            
            cell.isUserInteractionEnabled = false
            
            cell.hashTagNameLbl.layer.cornerRadius = 5
            cell.hashTagNameLbl.layer.masksToBounds = true
            shadowView(view: cell.myRoundView)
            
            
            if(myDictToSend.keys.contains("hashTag")){
                if let myHashName  = myDictToSend["hashTag"] as? String{
                    if(myHashName != ""){
                        cell.hashTagNameLbl.text = myHashName
                        cell.hashTagNameLbl.backgroundColor = UIColor.purple
                    }
                    else
                    {
                        cell.hashTagNameLbl.text = ""
                        cell.hashTagNameLbl.backgroundColor = UIColor.white
                    }
                    
                }
                else
                {
                    cell.hashTagNameLbl.text = ""
                    cell.hashTagNameLbl.backgroundColor = UIColor.white
                }
            }
            
            return cell
        }
        
        
        
        
    }
    
    
     @objc func viewAllActionFunc(sender: UIButton){
        
       let myDataDic = self.totalDataArray[sender.tag]
        
        let myArr = myDataDic["videos"] as! [[String:Any]]
        
        let storyBoard = UIStoryboard(name:"Main", bundle:nil)
        let allVideos = storyBoard.instantiateViewController(withIdentifier: "videosByHashTagViewController") as! videosByHashTagViewController
        
        allVideos.rawData = myDataDic
        allVideos.videosArray = myArr
        self.present(allVideos, animated: true, completion: nil)
        
        
    }
    
    @objc func songSelectFunc(notification: NSNotification)  {
        
        if let mysongNum = notification.userInfo?["songIndex"] as? Int {
            let indexPath = IndexPath(row: mysongNum, section: 0)
            self.categoriesTbl.selectRow(at: indexPath, animated: true, scrollPosition: .top) // <--
            self.categoriesTbl.delegate?.tableView!(self.categoriesTbl, didSelectRowAt: indexPath)
        }
        
        
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 210
//
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        DispatchQueue.main.async {
            let myDictToSend = self.totalDataArray[indexPath.row]
            
            let myArr = myDictToSend["videos"] as! [[String:Any]]
            
            let mycamPage = self.storyboard?.instantiateViewController(withIdentifier: "videosCollectionPreviewVC") as! videosCollectionPreviewVC
            
            mycamPage.myUrlsArray = myArr
            
            self.present(mycamPage, animated: true, completion: nil)
        }
       
    }
    
    @IBAction func searchBtn(_ sender: Any) {
        
        
        let storyBoard = UIStoryboard(name:"Main", bundle:nil)
        let signup = storyBoard.instantiateViewController(withIdentifier: "profileSearchVC") as! profileSearchVC
        //self.navigationController?.pushViewController(signup, animated: true)
        
        signup.height = self.view.frame.size.height - 40
        signup.topCornerRadius = 20
        signup.presentDuration = 0.3
        signup.dismissDuration = 0.4
        signup.shouldDismissInteractivelty = true
        signup.popupDelegate = self
        self.present(signup, animated: true, completion: nil)
    }
    
    
    
    func usersAPICall(){
        
        let url = URL(string: "http://testingmadesimple.org/training_app/api/Service/search")!
        
        URLSession.shared.dataTask(with: url, completionHandler: {
            
            (data, response, error) in
            
            if(error != nil){
                
                hideLoading(view: self.view)
                
                print("error")
                
            }else{
                
                do{
                    
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! NSDictionary
                    
                    print(json)
                    
                    if(json["status"] as! Int == 0)
                    {
                        DispatchQueue.main.async {
                            hideLoading(view: self.view)
                            self.view.makeToast("Something Went Wrong")
                        }
                        
                    }
                    else{
                        
                    }
                    
                    
                    
                }catch let error as NSError{
                    
                    print(error)
                    DispatchQueue.main.async {
                        hideLoading(view: self.view)
                        
                    }
                    
                }
                
            }
            
        }).resume()
        
    }
    
    
    
    
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
                        
                        self.totalDataArray = responseJSON["data"] as! [[String : Any]]
                        
                        if(self.withdataArray.count > 0){
                            self.withdataArray.removeAll()
                        }
                        if(self.withoutDataArray.count > 0){
                            self.withoutDataArray.removeAll()
                        }
                        
                        for i in 0..<self.totalDataArray.count{
                           
                            let mydict = self.totalDataArray[i]
                            
                            let myVideosAr = mydict["videos"] as? [[String:Any]]
                            
                            if(myVideosAr!.count > 0){
                                self.withdataArray.append("1")
                            }else{
                                self.withoutDataArray.append("0")
                            }
                        }
                        
                        
                        DispatchQueue.main.async {
                            hideLoading(view: self.view)
                            self.categoriesTbl.reloadData()
                            
                            
                            self.categoriesTbl.frame = CGRect(x: self.categoriesTbl.frame.origin.x, y: self.categoriesTbl.frame.origin.y, width: self.categoriesTbl.frame.size.width, height: CGFloat((self.withdataArray.count * 220) + (self.withoutDataArray.count * 83) ))
                            
                            self.heightView.constant =  self.collectionViw.frame.size.height  + self.middleView.frame.size.height +   self.categoriesTbl.frame.size.height
                            
                            
                            
                            self.scrolview.updateContentView()
                            
                                hideLoading(view: self.view)
                                self.categoriesTbl.reloadData()
                            
                            
                            
                        }
                        
                    }
                    else if(responseJSON["status"] as! Int == 1)
                    {
                        
                        
                        DispatchQueue.main.async {
                            hideLoading(view: self.view)
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
    
    
    
}


extension UIScrollView {
    func updateContentView() {
        contentSize.height = subviews.sorted(by: { $0.frame.maxY < $1.frame.maxY }).last?.frame.maxY ?? contentSize.height
    }
}



extension DiscoverViewController: BottomPopupDelegate {
    
    func bottomPopupViewLoaded() {
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
        print("bottomPopupDidDismiss")
    }
    
    func bottomPopupDismissInteractionPercentChanged(from oldValue: CGFloat, to newValue: CGFloat) {
        print("bottomPopupDismissInteractionPercentChanged fromValue: \(oldValue) to: \(newValue)")
    }
}
