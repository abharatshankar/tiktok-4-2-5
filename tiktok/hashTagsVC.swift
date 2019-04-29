//
//  hashTagsVC.swift
//  Tabbar
//
//  Created by Bharat shankar on 16/04/19.
//  Copyright © 2019 kETANpATEL. All rights reserved.
//

import UIKit

class hashTagsVC: UIViewController {

    
    
    @IBOutlet weak var searchField: UISearchBar!
    
    @IBOutlet weak var searchTableViwe: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.searchField.barTintColor = UIColor.white
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
