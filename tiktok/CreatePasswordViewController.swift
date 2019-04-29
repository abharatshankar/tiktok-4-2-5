//
//  CreatePasswordViewController.swift
//  tiktok
//
//  Created by ashwin challa on 2/21/19.
//  Copyright © 2019 Bharat shankar. All rights reserved.
//

import UIKit

class CreatePasswordViewController: UIViewController {

    
    
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var reenterPassword: UITextField!
    @IBOutlet weak var enterPassword: UITextField!
    
    let degaultsHelper = DefaultsHelper.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pageSetup()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
         self.tabBarController?.tabBar.isHidden = false
    }
    
    func pageSetup()  {
        
        
        self.reenterPassword.layer.borderWidth = 1
        self.reenterPassword.layer.cornerRadius = 15
        self.reenterPassword.layer.borderColor =  #colorLiteral(red: 0.8549019608, green: 0.662745098, blue: 1, alpha: 1)
        self.enterPassword.layer.borderWidth = 1
        self.enterPassword.layer.cornerRadius = 15
        self.enterPassword.layer.borderColor =  #colorLiteral(red: 0.8549019608, green: 0.662745098, blue: 1, alpha: 1)
        
        purpuleShadowView(view: self.reenterPassword)
        purpuleShadowView(view: self.enterPassword)
        
    }

    @IBAction func submitAction(_ sender: Any) {
        
        
        guard let text = enterPassword.text, !text.isEmpty else {
            self.view.makeToast("please enter Valid number")
            return
        }
        
        guard let text2 = reenterPassword.text, !text2.isEmpty else {
            self.view.makeToast("please enter Valid number")
            return
        }
        
        if text != text2 {
            self.view.makeToast("Password and confirm password not matched")
        }
        
        else
        {
            if(isValidPassword(password: text) == true){
                
                
                if(isValidPassword(password: text2) == true){
                    if  (self.degaultsHelper.getId().isEmpty != true && self.degaultsHelper.getId() != "")
                    {
                        postLoginCall(userId: self.degaultsHelper.getId(), password: text2)
                    }
                    else if  (self.degaultsHelper.getfbId().isEmpty != true && self.degaultsHelper.getfbId() != "")
                    {
                        postLoginCall(userId: self.degaultsHelper.getfbId(), password: text2)
                    }
                }else{
                    DispatchQueue.main.async {
                        self.view.makeToast("Password format is not matched")
                    }
                }
                
            }
            else{
                DispatchQueue.main.async {
                    self.view.makeToast("Password format is not matched")
                }
                
            }
            
            
            
        }
        
        
        
    }
    
    func isValidPassword(password: String) -> Bool {
        let passwordRegEx = "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{6,16}"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        let result = passwordTest.evaluate(with: password)
        return result
    }
    
    
    func postLoginCall(userId : String , password: String){
        
        
        let request = NSMutableURLRequest(url: NSURL(string: CREATE_PASSWORD)! as URL)
        request.httpMethod = "POST"
        let postString = "userId=\(userId)&password=\(password)"
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
                    
                    if(responseJSON["success"] as? Int == 1)
                    {
                        DispatchQueue.main.async {
//                            if let first = self.tabBarController!.viewControllers![0] as? UINavigationController {
//                                // popToRoot here
//                                first.popToRootViewController(animated:false)
//                            }

                            defaultsHelper.setId(userId)
                            defaultsHelper.setPassword(password)
                            
                            DispatchQueue.main.async {
                                self.dismiss(animated: true, completion: nil)
                            }
                            
                            
                        }
                        
                    }
                    else
                    {
                        DispatchQueue.main.async {
                            self.view.makeToast("Something went Wrong")
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


extension String {
    func matchingStrings(regex: String) -> [[String]] {
        guard let regex = try? NSRegularExpression(pattern: regex, options: []) else { return [] }
        let nsString = self as NSString
        let results  = regex.matches(in: self, options: [], range: NSMakeRange(0, nsString.length))
        return results.map { result in
            (0..<result.numberOfRanges).map {
                result.range(at: $0).location != NSNotFound
                    ? nsString.substring(with: result.range(at: $0))
                    : ""
            }
        }
    }
}
