//
//  signupWithEmailVC.swift
//  tiktok
//
//  Created by Bharat shankar on 28/02/19.
//  Copyright © 2019 Bharat shankar. All rights reserved.
//

import UIKit

class signupWithEmailVC: UIViewController {

    @IBOutlet weak var emailSubmitBtn: UIButton!
    @IBOutlet weak var emailTxtFld: UITextField!
    var mobileData : signupMobileData?
    override func viewDidLoad() {
        super.viewDidLoad()

        purpuleShadowView(view: self.emailTxtFld)
self.emailTxtFld.layer.borderWidth = 1
        self.emailTxtFld.layer.cornerRadius = 16
        self.emailTxtFld.layer.borderColor = #colorLiteral(red: 0.8549019608, green: 0.662745098, blue: 1, alpha: 1)
        
        // for menu burger icon
        let burgerBtn = UIButton(type: UIButton.ButtonType.custom)
        burgerBtn.setImage(UIImage(named:"previous-wite-36"), for: UIControl.State())
        burgerBtn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        let burgerBtnItem = UIBarButtonItem(customView: burgerBtn)
        let width1 = burgerBtnItem.customView?.widthAnchor.constraint(equalToConstant: 22)
        width1?.isActive = true
        let height1 = burgerBtnItem.customView?.heightAnchor.constraint(equalToConstant: 22)
        height1!.isActive = true
        
        navigationItem.leftBarButtonItems = [burgerBtnItem]
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.5529411765, green: 0, blue: 0.968627451, alpha: 1)
        
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.5529411765, green: 0, blue: 0.968627451, alpha: 1)
        
        // Remove the background color.
       // navigationController?.navigationBar.setBackgroundImage(UIColor.clear.as1ptImage(), for: .default)
        
        // Set the shadow color.
       // navigationController?.navigationBar.shadowImage = UIColor.purple.as1ptImage()
        
        
    }
    
    @objc func buttonAction()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.5529411765, green: 0, blue: 0.968627451, alpha: 1)
        self.navigationItem.setHidesBackButton(true, animated:true);

        // Remove the background color.
       // navigationController?.navigationBar.setBackgroundImage(UIColor.clear.as1ptImage(), for: .default)
        
        // Set the shadow color.
       // navigationController?.navigationBar.shadowImage = UIColor.white.as1ptImage()
        
        
    }

    
    
    @IBAction func emailSignUp(_ sender: Any) {
        guard let text = emailTxtFld.text, !text.isEmpty else {
            self.view.makeToast("please enter Valid Email")
            return
        }
        
        if (isValidEmail(testStr: text) == true) {
            if(Reachability.isConnectedToNetwork() == true)
            {
                postTestApi(type: "email", username: text, info: "", countryCode: "")
            }
            else
            {
                self.view.makeToast("Check your Connection")
            }
        }
        else
        {
             self.view.makeToast("please enter Valid number")
        }
    }
    
    func postTestApi(type: String , username:String ,info:String , countryCode:String )  {
        let url = URL(string: "http://68.183.81.213:4200/api/v1/users")!
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let coordinate = Coordinate(id: "", type: type , username: username, info: info, countryCode: countryCode)
        // set this however you want
        request.httpBody = try! JSONEncoder().encode(coordinate)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                print(error ?? "Unknown error")
                return
            }
            
            do {
                let responseObject = try JSONSerialization.jsonObject(with: data)
                let jsonDecoder = JSONDecoder()
                
                
                //print("asdasd",self.postclassVariableInstance?.homeproducts?.newarrival!)
                self.mobileData = try
                    jsonDecoder.decode(signupMobileData.self, from: data)
                
                if self.mobileData?.data1?.status == 0
                    
                {
                    
                    
                    
                    //saving values in default helper
                    
                    if let myid = self.mobileData?.data1?.id{
                        
                        DEFAULT_HELPER.setId(myid)
                        
                    }
                        
                    else
                        
                    {
                        
                        self.view.makeToast("Something went wrong")
                        
                        
                        
                        return
                        
                    }
                    
                    
                    
                }
                else if self.mobileData?.data1?.status == 1
                    
                {
                    
                }
                
                
                print(self.mobileData?.message as Any)
                //print(self.mobileData?.otp)
                
                
                
                //                self.productsClass = try jsonDecoder.decode(Product.self, from: data)
                
                print(responseObject)
                DispatchQueue.main.async(execute: {
                    //otpViewController
                    let storyBoard = UIStoryboard(name:"Main", bundle:nil)
                    let otpview = storyBoard.instantiateViewController(withIdentifier: "otpViewController") as! otpViewController
                    self.navigationController?.pushViewController(otpview, animated: true)
                    
                })
                
                
            } catch let parseError {
                print(parseError)
            }
            }.resume()
    }
    
    struct Coordinate: Codable {
        var id: String
        var type : String
        var username : String
        var info : String
        var countryCode : String
        
    }


}
