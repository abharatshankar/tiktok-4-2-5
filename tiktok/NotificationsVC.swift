//
//  NotificationsVC.swift
//  tiktok
//
//  Created by Dr Mohan Roop on 4/7/19.
//  Copyright © 2019 Bharat shankar. All rights reserved.
//

import UIKit

class NotificationsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    @IBOutlet weak var notificationTV: UITableView!
    
    var myNotificationsArray = [[String:Any]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        notificationTV.delegate = self
        notificationTV.dataSource = self
        notificationTV.estimatedRowHeight = 109
        notificationTV.rowHeight = UITableView.automaticDimension
        
        APICall()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        APICall()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return self.myNotificationsArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableCell", for: indexPath) as! NotificationTableCell
        cell.selectionStyle = .none
        
        let mydix = self.myNotificationsArray[indexPath.row]
        if let myTitle = mydix["userId"] as? String
        {
            let last4 = String(myTitle.suffix(4))
            cell.NotificationTitle.text = "User"+last4+" Posted a video"
        }
        
        cell.notificationImg.layer.borderWidth = 2
        cell.notificationImg.layer.borderColor = #colorLiteral(red: 0.5529411765, green: 0, blue: 0.968627451, alpha: 1)
        return cell
        
    }
    
    
    func APICall(){
        
        //loader
        showLoading(view: self.view)
        
        let url = URL(string: "http://www.testingmadesimple.org/training_app/api/Service/listNotifications")!
        
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
                    
                    
                    
                    //Data to store into arrays and dictionaries
                    if(json["status"] as! Int == 0)
                    {
                        self.view.makeToast("Something Went Wrong")
                    }
                    else if(json["status"] as! Int == 1)
                    {
                        if let myDataArray = json["data"] as? [[String:Any]]
                        {
                           self.myNotificationsArray = myDataArray
                        }
                        
                    }
                    
                    
                    //main thread
                    DispatchQueue.main.async{
                   
                        self.notificationTV.reloadData()
                        
                    }
                    
                    
                    
                }catch let error as NSError{
                    
                    print(error)
                    
                }
            }
            
        }).resume()
        
        
        
    }

}
