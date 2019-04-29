//
//  SignUpWithMobileViewController.swift
//  tiktok
//
//  Created by ashwin challa on 2/21/19.
//  Copyright © 2019 Bharat shankar. All rights reserved.
//

import UIKit
import Toast_Swift
import SDWebImage

class SignUpWithMobileViewController: UIViewController , UITableViewDelegate , UITableViewDataSource , UITextFieldDelegate{
    @IBOutlet weak var mobileNumber: UITextField!
    var countryArray = [[String:Any]]()
    
    var mobileData : signupMobileData?

    var myyPhoneData : data?
    var helpers = DefaultsHelper.init()
    
    var countriesNames = [String]()
    
    
    
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var countryTbl: UITableView!
    @IBOutlet weak var countryCodeBtn: UIButton!
    @IBOutlet weak var countryCodeTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.countryTbl.isHidden = true
        
        self.mobileNumber.layer.borderWidth = 1
        self.mobileNumber.layer.cornerRadius = 15
       
        self.countryCodeBtn.layer.borderWidth = 1
        self.countryCodeBtn.layer.cornerRadius = 15
        self.countryCodeBtn.layer.borderColor = #colorLiteral(red: 0.8549019608, green: 0.662745098, blue: 1, alpha: 1)
        purpuleShadowView(view: self.countryCodeBtn)
        
        self.countryTbl.backgroundColor = UIColor.clear
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.frame
        self.countryTbl.separatorEffect = UIVibrancyEffect(blurEffect: blurEffect)
        self.countryTbl.backgroundView = blurEffectView
        
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
    
    @objc func buttonAction()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitBtnAction(_ sender: Any) {
        
        guard let text = mobileNumber.text, !text.isEmpty else {
            self.view.makeToast("please enter Valid number")
            return
        }
        
        guard let myCountryCode = self.countryCodeBtn.titleLabel?.text, !text.isEmpty else {
            self.view.makeToast("please enter Valid country code")
            return
        }
        
        if (isValidPhoneNumber(text) == true) {
            if(Reachability.isConnectedToNetwork() == true)
            {
                postTestApi(type: "mobile", username: text, info: "", countryCode: myCountryCode)
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
    
    @IBAction func privacyPolicyAction(_ sender: Any) {
        self.view.makeToast("Privacy policy Clicked")
    }
    
    @IBAction func termsOfUseAction(_ sender: Any) {
         self.view.makeToast("Terms of Use Clicked")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
      
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.5529411765, green: 0, blue: 0.968627451, alpha: 1)
        
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.5529411765, green: 0, blue: 0.968627451, alpha: 1)
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
         navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.5529411765, green: 0, blue: 0.968627451, alpha: 1)
        self.navigationItem.setHidesBackButton(true, animated:true);
        
    }
    
    @IBAction func countryCodeAction(_ sender: Any) {
        if let path = Bundle.main.path(forResource: "country", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let person = jsonResult["countryCodes"] as? [Any] {
                    // do stuff
                    print(person)
                    countryArray = person as! [[String : Any]]
                    let myData = countryArray[0] 
                    print(myData)
                    
                    
                    //countriesNames
                    for index in 1..<countryArray.count {
                        let myname = countryArray[index] ["country_name"] as! String
                        countriesNames.append(myname)
                    }
                    
                    self.countryTbl.isHidden = false
                    countryTbl.reloadData()
                    
                    
                }
            } catch {
                // handle error
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    
    {
        return countryArray.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    
     {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryTableViewCell", for: indexPath) as! countryTableViewCell
        let nameOfCountry = countryArray[indexPath.row] ["country_name"] as! String
        let imgNam =  countryArray[indexPath.row] ["country_code"] as! String
        cell.countryNameLbl.text = nameOfCountry
        cell.countryImgLbl.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: imgNam.lowercased()))
        
        cell.contentView.backgroundColor = UIColor.clear
        cell.countryNameLbl.backgroundColor = UIColor.clear

        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = countryArray[indexPath.row] ["dialling_code"] as! String
        self.countryCodeBtn.setTitle("  " + name, for: .normal)
        
        self.countryTbl.isHidden = true
    }
    
    //enter 10 digits in mobile field
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
    
    
    func postTestApi(type: String , username:String ,info:String , countryCode:String )  {
        let url = URL(string: CREATE_USER_API)!
        
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
                
                print(responseObject)
                self.mobileData = try
                    jsonDecoder.decode(signupMobileData.self, from: data)
                
                
                if(self.mobileData?.data1?.status == 0)
                {

                    print(self.mobileData?.message as Any)
                    
                    DispatchQueue.main.async {
                        // Update UI
                        let storyBoard = UIStoryboard(name:"Main", bundle:nil)
                        let otp = storyBoard.instantiateViewController(withIdentifier: "otpViewController") as! otpViewController
                        otp.mobileStr = self.mobileData?.data1?.username ?? ""
                        self.helpers.setId(self.mobileData?.data1?.id ?? "")
                        self.navigationController?.pushViewController(otp, animated: true)
                    }
                    
                }
                else
                {
                    self.view.makeToast("Server error")
                }
                
                
                print(responseObject)
            } catch let parseError {
                print(parseError.localizedDescription)
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

