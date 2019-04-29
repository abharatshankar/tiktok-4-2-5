//
//  mobileLoginVC.swift
//  tiktok
//
//  Created by Bharat shankar on 05/03/19.
//  Copyright © 2019 Bharat shankar. All rights reserved.
//

import UIKit

class mobileLoginVC: UIViewController {

    @IBOutlet weak var countryCodeBtn: UIButton!
    @IBOutlet weak var mobileNumberTxtFld: UITextField!
    
    @IBOutlet weak var passwordTxtFld: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.setHidesBackButton(true, animated:true);

        self.countryCodeBtn.layer.borderWidth = 1
        self.countryCodeBtn.layer.borderColor =  #colorLiteral(red: 0.8549019608, green: 0.662745098, blue: 1, alpha: 1)
        self.countryCodeBtn.layer.cornerRadius = 15
        self.passwordTxtFld.layer.borderWidth = 1
        self.passwordTxtFld.layer.cornerRadius = 15
        self.passwordTxtFld.layer.borderColor =  #colorLiteral(red: 0.8549019608, green: 0.662745098, blue: 1, alpha: 1)
        
        purpuleShadowView(view: self.countryCodeBtn)
        purpuleShadowView(view: self.passwordTxtFld)
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func submitAction(_ sender: Any) {
        
        
        
    }
    
    
    

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let length: Int = textField.text?.count ?? 0
        if length > 9 && !(string == "") {
            return false
        }
        // This code will provide protection if user copy and paste more then 10 digit text
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
            if (textField.text?.count ?? 0) > 10 {
                textField.text = (textField.text as? NSString)?.substring(to: 10)
            }
        })
        return true
    }


}
