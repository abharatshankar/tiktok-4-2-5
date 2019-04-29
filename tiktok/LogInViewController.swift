//
//  LogInViewController.swift
//  tiktok
//
//  Created by ashwin challa on 2/21/19.
//  Copyright © 2019 Bharat shankar. All rights reserved.
//

import UIKit
import Toast_Swift

class LogInViewController: UIViewController {
    @IBOutlet weak var mobileNumberTxtFld: UITextField!
     
    @IBOutlet weak var passwordTxtFld: UITextField!
    
   //let utilities =
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        self.mobileNumberTxtFld.layer.borderWidth = 1
        self.mobileNumberTxtFld.layer.borderColor =  #colorLiteral(red: 0.8549019608, green: 0.662745098, blue: 1, alpha: 1)
        self.mobileNumberTxtFld.layer.cornerRadius = 15
        self.passwordTxtFld.layer.borderWidth = 1
        self.passwordTxtFld.layer.cornerRadius = 15
        self.passwordTxtFld.layer.borderColor =  #colorLiteral(red: 0.8549019608, green: 0.662745098, blue: 1, alpha: 1)
        
        purpuleShadowView(view: self.mobileNumberTxtFld)
        purpuleShadowView(view: self.passwordTxtFld)
        
        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
         self.tabBarController?.tabBar.isHidden = false
    }
    
    
    
    func loginPostServiceCall(userId : String , videoId : String ,mycomment : String , parentId : String , url: String){
        
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        
        
        let mySendDict:[String:String] = ["userId":userId, "videoId":videoId, "comment":mycomment , "parentId":parentId]
        
        
        
        let postString = self.jsonString(dictionary: mySendDict)
        // let postString = "userId=\(userId)&videoId=\(videoId)&comment=\(comment)&parentId=\(parentId)"
        print(postString)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            do {
                if let responseJSON = try JSONSerialization.jsonObject(with: data!) as? [String:AnyObject]{
                    print(responseJSON)
                    
                    if (responseJSON.keys.contains("data")){
                        if responseJSON["data"] != nil
                        {
                            
                            DispatchQueue.main.async{
                                
                                
                            }
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
    
    
    
    
    func jsonString(dictionary : [String:String]) -> String {
        if let theJSONData = try? JSONSerialization.data(
            withJSONObject: dictionary,
            options: []) {
            let theJSONText = String(data: theJSONData,
                                     encoding: .ascii)
            print("JSON string = \(theJSONText!)")
            return theJSONText!
        }
        else
        {
            return ""
        }
    }
    
    
    
}
