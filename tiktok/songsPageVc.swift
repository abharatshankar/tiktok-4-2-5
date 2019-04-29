//
//  songsPageVc.swift
//  Tabbar
//
//  Created by Bharat shankar on 16/04/19.
//  Copyright © 2019 kETANpATEL. All rights reserved.
//

import UIKit

class songsPageVc: UIViewController , UITableViewDataSource , UITableViewDelegate ,UISearchBarDelegate {

    //search array
    var searchArr = [[String:Any]]()
    
    
    @IBOutlet weak var searchField: UISearchBar!
    
    @IBOutlet weak var searchTableViwe: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.searchField.barTintColor = UIColor.white
    }
    

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 0 {
            APISearchCall(text: searchText)
        }
        else
        {
            if(searchArr.count > 0){
                self.searchArr.removeAll()
                self.searchTableViwe.reloadData()
            }
            
        }
        
    }
    
    
    
    //search service call
    func APISearchCall(text:String){
        //internet connection
        if Reachability.isConnectedToNetwork() == true
        {
            print("internet connection is there")
            
            
            //loader
            showLoading(view: self.view)
            
            
            
                    self.UsersPostServiceCall(url: SONG_SEARCH_API, userId: DEFAULT_HELPER.getId(), searchText: text)
            
            
            
        }
        else
        {
            self.view.makeToast("Check Your Internet Connection")
            
        }
        
    }
    
    //table view data source method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return searchArr.count
    }
    
    //table view delegate method
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //table view delegate method
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let storyBoard = UIStoryboard(name:"Main", bundle:nil)
        //        let details = storyBoard.instantiateViewController(withIdentifier: "ProductDeatilsViewController") as! ProductDeatilsViewController
        //
        //        let dixeach = self.searchArr[indexPath.row] as! [String:Any]
        //        let itemsid = dixeach["items_id"] as! String
        //
        //        details.productitemsidkey = dixeach["items_id"] as! String
        //
        //
        //        self.navigationController?.pushViewController(details, animated: true)
    }
    
    //table view datasource method
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "songsSearchTableViewCell", for: indexPath) as! songsSearchTableViewCell
        
        let myDic = self.searchArr[indexPath.row]
        if let songname = myDic["file"] as? String{
            cell.songNameLbl.text = songname
        }
        
        if let movieName = myDic["name"] as? String{
            cell.movieNameLbl.text = movieName
        }
        
        
        return cell
    }
    
    
    
    
    func UsersPostServiceCall(url : String , userId : String , searchText : String){
        
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        let postString = "userId=\(userId)&search=\(searchText)"
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
                    DispatchQueue.main.async {
                        
                        hideLoading(view: self.view)
                    }
                    
                    if(responseJSON["status"] as! Int == 0)
                    {
                        DispatchQueue.main.async {
                            
                            hideLoading(view: self.view)
                            
                            if(self.searchArr.count > 0){
                                self.searchArr.removeAll()
                            }
                            
                            if let myResponse = responseJSON["data"] as? [[String:Any]]{
                                self.searchArr = myResponse
                                self.searchTableViwe.reloadData()
                            }
                            
                            // self.searchArr.append(<#T##newElement: [String : Any]##[String : Any]#>)
                            
                            
                        }
                    }
                    else if(responseJSON["status"] as! Int == 1)
                    {
                        DispatchQueue.main.async {
                            
                            hideLoading(view: self.view)
                            self.view.makeToast("Something Went Wrong")
                        }
                        
                    }
                    else{
                        DispatchQueue.main.async {
                            
                            hideLoading(view: self.view)
                            self.view.makeToast("No data found")
                        }
                    }
                }
            }
            catch {
                DispatchQueue.main.async {
                    
                    hideLoading(view: self.view)
                    self.view.makeToast("Something Went Wrong")
                }
                print("Error -> \(error)")
            }
            
        }
        
        task.resume()
        
    }
    
    
    
    
    //remove special characters
    func removeSpecialCharsFromString(text: String) -> String {
        let okayChars : Set<Character> =
            Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890+-*=(),.:!_".characters)
        return String(text.characters.filter {okayChars.contains($0) })
    }
    
    

}
