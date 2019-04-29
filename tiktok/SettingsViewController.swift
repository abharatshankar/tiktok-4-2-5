//
//  SettingsViewController.swift
//  tiktok
//
//  Created by ashwin challa on 4/22/19.
//  Copyright © 2019 Bharat shankar. All rights reserved.
//

import UIKit

protocol SlideMenuDelegate {
    func slideMenuItemSelectedAtIndex(_ index : Int,section:Int)
}



class SettingsViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    
      var sectionIndex = 0
    
    var secondArrayMenuOptions = [Dictionary<String,String>]()


    @IBOutlet weak var settingsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        
        
        updateSecondArrayMenuOptions()
        
        
        
        
    }
    
    
    
    func updateSecondArrayMenuOptions(){
        
        
        secondArrayMenuOptions.append(["title":"Push Notifications", "icon":"notifications (1)"])
        secondArrayMenuOptions.append(["title":"About Us", "icon":"aboutus (1)"])
        secondArrayMenuOptions.append(["title":"Privacy and Safety", "icon":"privacy_safety (1)"])
        secondArrayMenuOptions.append(["title":"Help Center", "icon":"help (1)"])
        secondArrayMenuOptions.append(["title":"Terms of Use", "icon":"termsuse (1)"])
        secondArrayMenuOptions.append(["title":"Privacy Policy", "icon":"privacy (1)"])
        secondArrayMenuOptions.append(["title":"Copyrights Policy", "icon":"copyright (1)"])
        secondArrayMenuOptions.append(["title":"Logout", "icon":"logout (2)"])
        
        
        settingsTableView.reloadData()
    }
    
    
    //table view datasource method
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
            //deque reusable cell
            
            let cell = tableView.dequeueReusableCell(withIdentifier:"SettingsTableViewCell" , for: indexPath) as! SettingsTableViewCell
            
            
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.layoutMargins = UIEdgeInsets.zero
            cell.preservesSuperviewLayoutMargins = false
            cell.backgroundColor = UIColor.clear
            //set the data here
            
            cell.settingsLabel.text = secondArrayMenuOptions[indexPath.row]["title"]!
            
            cell.settingsImage.image = UIImage(named: secondArrayMenuOptions[indexPath.row]["icon"]!)
            
            return cell
        }
            
    
    
    
    //table view delegate method
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
      
        if case indexPath.row = 0 {
            let storyBoard = UIStoryboard(name:"Main", bundle:nil)
            let push = storyBoard.instantiateViewController(withIdentifier: "PushNotificationsViewController")
            self.navigationController?.pushViewController(push, animated: true)
        }
        else if case indexPath.row = 1 {
            
        }
        else if case indexPath.row = 2 {
            
        }
        else if case indexPath.row = 3 {
            
        }
        else if case indexPath.row = 4 {
            
        }
        else if case indexPath.row = 5 {
            
        }
        else if case indexPath.row = 6 {
            
        }
        else if case indexPath.row = 7 {
            // logout alert
            let logoutAlert = UIAlertController(title: "Do you Really Want to Logout?", message: "", preferredStyle: UIAlertController.Style.alert)
            
            logoutAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
                
                self.resetDefaults()
                
            }))
            
            logoutAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
                print("Handle Cancel Logic here")
            }))
            
            present(logoutAlert, animated: true, completion: nil)
            
        }
        
            
        
    }
    
    
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
    
    //table view data source method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return arrayMenuOptions.count
        
       
            return secondArrayMenuOptions.count
        
    
    }
    
    //table view data source method
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    
    
    
    
}



