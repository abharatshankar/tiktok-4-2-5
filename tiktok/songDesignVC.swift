//
//  songDesignVC.swift
//  tiktok
//
//  Created by Bharat shankar on 29/04/19.
//  Copyright © 2019 Bharat shankar. All rights reserved.
//

import UIKit


class songDesignVC: UIViewController,FSPagerViewDelegate,FSPagerViewDataSource , UITableViewDataSource , UITableViewDelegate {

    
    @IBOutlet weak var heightAnchor: NSLayoutConstraint!
    
    @IBOutlet weak var myScroll: UIScrollView!
    
    @IBOutlet weak var songsTV: UITableView!
    
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.pagerView.itemSize = FSPagerView.automaticSize
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        songsTV.estimatedRowHeight = 227
        songsTV.rowHeight = UITableView.automaticDimension
        
        self.pagerView.automaticSlidingInterval = 3.0 - self.pagerView.automaticSlidingInterval
        
        if Reachability.isConnectedToNetwork() == true
        {
            if(DEFAULT_HELPER.getId().isEmpty != true){
                if(DEFAULT_HELPER.getId() != ""){
                    self.songsPostServiceCall(url: SONGS_API, videoId: "", myuserId: DEFAULT_HELPER.getId())
                }
               
            }else if(DEFAULT_HELPER.getfbId().isEmpty != true){
                if(DEFAULT_HELPER.getfbId() != ""){
                    self.songsPostServiceCall(url: SONGS_API, videoId: "", myuserId: DEFAULT_HELPER.getfbId())
                }
                
            }
            
        }
        else
        {
            self.view.makeToast("Check your connection")
        }
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
         let numberOfRows = 10
        let heightOfCell = 227
        self.songsTV.frame = CGRect(x: 0, y: 366, width: 375, height: numberOfRows * heightOfCell)
        
        self.heightAnchor.constant = CGFloat(numberOfRows * heightOfCell  + 20)
        
        self.myScroll.updateContentView()
    }
    
    
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 10
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "songsCatTableViewCell", for: indexPath)  as! songsCatTableViewCell
            cell.selectionStyle = .none
            
            cell.titleLbl.tag = indexPath.row
            
            cell.catSelection.tag = indexPath.row
            
            shadowView(view: cell.backView)
            
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "songsSectionTableViewCell", for: indexPath)  as! songsSectionTableViewCell
            cell.selectionStyle = .none
            
            cell.titleLbl.text = "Testing title"
            
            cell.backView.backgroundColor = UIColor.white
            cell.titleLbl.tag = indexPath.row
            
            //cell.catselection.tag = indexPath.row
            
            shadowView(view: cell.backView)
            
            
            return cell
        }
        
        
    }
    
    // MARK:- Service call
    //SONGS_API
    
    
    func songsPostServiceCall(url : String , videoId : String , myuserId : String){
        
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        let postString = "userId=\(myuserId)&limit=\(0)&contentoffset\(10)"
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
}

