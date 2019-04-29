//
//  forgotPasswordViewController.swift
//  tiktok
//
//  Created by Bharat shankar on 05/03/19.
//  Copyright © 2019 Bharat shankar. All rights reserved.
//

import UIKit

class forgotPasswordViewController: UIViewController {
    @IBOutlet weak var countryCodeButton: UIButton!
    @IBOutlet weak var emailTxtFld: UITextField!
    
    @IBOutlet weak var mobileNumberTxtFld: UITextField!
    
    @IBOutlet weak var mobileButton: UIButton!
    
    @IBOutlet weak var emailButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       self.emailTxtFld.isHidden = true
        self.countryCodeButton.layer.borderWidth = 1
        self.countryCodeButton.layer.borderColor =  #colorLiteral(red: 0.8549019608, green: 0.662745098, blue: 1, alpha: 1)
        self.countryCodeButton.layer.cornerRadius = 15
        self.emailTxtFld.layer.borderWidth = 1
        self.emailTxtFld.layer.cornerRadius = 15
        self.emailTxtFld.layer.borderColor =  #colorLiteral(red: 0.8549019608, green: 0.662745098, blue: 1, alpha: 1)
        
        purpuleShadowView(view: self.countryCodeButton)
        purpuleShadowView(view: self.emailTxtFld)
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func mobileSelectAction(_ sender: Any) {
        self.emailTxtFld.isHidden = true
        self.countryCodeButton.isHidden = false
        self.mobileNumberTxtFld.isHidden = false
        
    }
    
    @IBAction func emailSelectAction(_ sender: Any) {
        
        self.countryCodeButton.isHidden = true
        self.mobileNumberTxtFld.isHidden = true
        self.emailTxtFld.isHidden = false
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
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
