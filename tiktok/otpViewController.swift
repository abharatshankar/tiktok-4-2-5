//
//  otpViewController.swift
//  tiktok
//
//  Created by Bharat shankar on 21/02/19.
//  Copyright © 2019 Bharat shankar. All rights reserved.
//

import UIKit

class otpViewController: UIViewController , UITextFieldDelegate {

    @IBOutlet weak var txt1: UITextField!
    
    @IBOutlet weak var txt2: UITextField!
    
    @IBOutlet weak var txt3: UITextField!
    
    @IBOutlet weak var txt4: UITextField!
    
    @IBOutlet weak var txt5: UITextField!
    
    @IBOutlet weak var txt6: UITextField!
    
    var mobileStr = ""
    var numOrMailStr = ""
    let helpers = DefaultsHelper.init()
     var otpData : otpCodableData?
    
    @IBOutlet weak var mobileNumberLbl: UILabel! 
    
    @IBOutlet weak var numberOrMailLbl: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pageSetup()
        
        
    }
    
    func pageSetup()  {
        
        self.lineText(textBox: txt1)
        self.lineText(textBox: txt2)
        self.lineText(textBox: txt3)
        self.lineText(textBox: txt4)
        self.lineText(textBox: txt5)
        self.lineText(textBox: txt6)
        
        
        self.mobileNumberLbl.text = "Sent to" + mobileStr
        
        self.numberOrMailLbl.text = numOrMailStr
    self.numberOrMailLbl.adjustsFontSizeToFitWidth = true
        
    }
    
    
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func lineText(textBox: UITextField)  {
        
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.gray.cgColor
        border.frame = CGRect(x: 0, y: textBox.frame.size.height - width, width: textBox.frame.size.width, height: textBox.frame.size.height)
        
        border.borderWidth = width
        textBox.layer.addSublayer(border)
        textBox.layer.masksToBounds = true
        
    }

    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        
        if textField.text!.count < 1 && string.count > 0 {
            let tag = textField.tag + 1;
            let nextResponder = textField.superview?.viewWithTag(tag)
            
            if   (nextResponder != nil){
                textField.resignFirstResponder()
                
            }
            textField.text = string;
            if (nextResponder != nil){
                nextResponder?.becomeFirstResponder()
                
            }
            return false;
            
            
        }else if (textField.text?.count)! >= 1 && string.count == 0 {
            let prevTag = textField.tag - 1
            let prevResponser = textField.superview?.viewWithTag(prevTag)
            if (prevResponser != nil){
                textField.resignFirstResponder()
            }
            textField.text = string
            if (prevResponser != nil){
                prevResponser?.becomeFirstResponder()
                
            }
            return false
        }
        
        
        return true;
        
    }
    
    
    
    @IBAction func submitAction(_ sender: Any) {
        
        guard let text = txt1.text, !text.isEmpty else {
            self.view.makeToast("please enter Valid otp")
            return
        }
        
        guard let text2 = txt2.text, !text2.isEmpty else {
            self.view.makeToast("please enter Valid otp")
            return
        }
        
        guard let text3 = txt3.text, !text3.isEmpty else {
            self.view.makeToast("please enter Valid otp")
            return
        }
        
        guard let text4 = txt4.text, !text4.isEmpty else {
            self.view.makeToast("please enter Valid otp")
            return
        }
        
        guard let text5 = txt5.text, !text5.isEmpty else {
            self.view.makeToast("please enter Valid otp")
            return
        }
        
        guard let text6 = txt6.text, !text6.isEmpty else {
            self.view.makeToast("please enter Valid otp")
            return
        }
        
        if ((helpers.getId() as NSString?) != nil) && (helpers.getId() != "") {
            let fullOtpStr = text + text2 + text3 + text4 + text5 + text6
            postTestApi(userid: helpers.getId(), otp: fullOtpStr)
        }
        else if ((helpers.getfbId() as NSString?) != nil) && (helpers.getfbId() != "") {
            let fullOtpStr = text + text2 + text3 + text4 + text5 + text6
            postTestApi(userid: helpers.getfbId(), otp: fullOtpStr)
        }
            
        else
        {
            self.view.makeToast("please enter Valid otp")
            
        }
        
       
        
    }
    
    
    
    func postTestApi(userid: String , otp:String  )  {
        let url = URL(string: OTP_API)!
        
        DispatchQueue.main.async {
            showLoading(view: self.view)
        }
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let coordinate = Coordinate(userId: userid, otp: otp)
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
                
                print(responseObject)
                self.otpData = try
                    jsonDecoder.decode(otpCodableData.self, from: data)


                if(self.otpData?.message == "OTP successfully verified")
                {

                    DispatchQueue.main.async {
                        // Update UI
                        

                        hideLoading(view: self.view)
                        let storyBoard = UIStoryboard(name:"Main", bundle:nil)
                        let passVc = storyBoard.instantiateViewController(withIdentifier: "CreatePasswordViewController") as! CreatePasswordViewController
                        
                        self.navigationController?.pushViewController(passVc, animated: true)
                    }

                }
                else
                {
                    DispatchQueue.main.async {
                         hideLoading(view: self.view)
                    }
                    self.view.makeToast("Server error")
                }
                
                
                print(responseObject)
            } catch let parseError {
                DispatchQueue.main.async {
                    hideLoading(view: self.view)
                }
                print(parseError)
            }
            }.resume()
    }
    
    struct Coordinate: Codable {
        var userId: String
        var otp : String
       
        
    }

}
