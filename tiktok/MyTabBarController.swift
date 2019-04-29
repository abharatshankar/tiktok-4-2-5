//
//  MyTabBarController.swift
//  tiktok
//
//  Created by Bharat shankar on 19/02/19.
//  Copyright © 2019 Bharat shankar. All rights reserved.
//

import Foundation
import UIKit

class MyTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tell our UITabBarController subclass to handle its own delegate methods
        self.delegate = self
    }
    
    // called whenever a tab button is tapped
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        if viewController is ViewController {
            print("First tab")
        } else if viewController is ProfileViewController {
            print("Second tab")
        }
    }
}
