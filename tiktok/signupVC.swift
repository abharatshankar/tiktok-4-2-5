//
//  signupVC.swift
//  tiktok
//
//  Created by Bharat shankar on 20/02/19.
//  Copyright © 2019 Bharat shankar. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import FBSDKLoginKit
import FBSDKCoreKit
import Toast_Swift
import SDWebImage
import GoogleSignIn
import TwitterCore
import TwitterKit

class signupVC: UIViewController , GIDSignInDelegate , GIDSignInUIDelegate{
    
    var height: CGFloat?
    var topCornerRadius: CGFloat?
    var presentDuration: Double?
    var dismissDuration: Double?
    var shouldDismissInteractivelty: Bool?
    
    
     private let sdkManager: FBSDKLoginManager = FBSDKLoginManager()
    var mobileData : signupMobileData?
    let defaltsHlpr = DefaultsHelper.init()
    //here gmail sign up action
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error != nil) {
            print("failed of gmail")
        }else
        {
            print(user.profile.hasImage)
            print("successssss")
            print(user.profile.email!)
            print(user.profile.name!)
            print(user.userID!)
            if user.profile.hasImage
            {
                let pic = user.profile.imageURL(withDimension: 100)
                print(pic)
            }
            
                if(Reachability.isConnectedToNetwork() == true)
                {
            postTestApi(type: "gmail", username: user.userID!, info: "", countryCode: "")
                }
                else
                {
                    self.view.makeToast("Check your Connection")
                }
            
        }
        
    }

    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sdkManager.loginBehavior = .systemAccount
        
        self.navigationItem.setHidesBackButton(true, animated:true);
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "MiddlebTnHide"), object: nil, userInfo: nil)

        
        // for menu burger icon
        let burgerBtn = UIButton(type: UIButton.ButtonType.custom)
        burgerBtn.setImage(UIImage(named:"previous-back-36"), for: UIControl.State())
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
    
    
    
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.5529411765, green: 0, blue: 0.968627451, alpha: 1)
        
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.5529411765, green: 0, blue: 0.968627451, alpha: 1)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    
    
    
    
    
    @IBAction func loginAction(_ sender: Any) {
        self.view.makeToast(" signup Action")

    }
    
    
    
    
    
    
    @IBAction func mobileSignup(_ sender: Any) {
        self.view.makeToast("Mobile signup")

        let jobDetail = storyboard?.instantiateViewController(withIdentifier: "SignUpWithMobileViewController") as! SignUpWithMobileViewController
        navigationController?.pushViewController(jobDetail, animated: false)
        
    }
    
    
    
    
    
    
    
    @IBAction func emailSignup(_ sender: Any) {
        self.view.makeToast("Email signup")

        let jobDetail = storyboard?.instantiateViewController(withIdentifier: "signupWithEmailVC") as! signupWithEmailVC
        navigationController?.pushViewController(jobDetail, animated: false)
    }
    
    
    
    
    
    
    
    @IBAction func fbSignup(_ sender: Any) {
        
        if(Reachability.isConnectedToNetwork() == true)
        {
            showLoading(view: self.view)
            let loginManager = LoginManager()
            
            // loginManager.loginBehavior = .systemAccount
            sdkManager.loginBehavior = .browser
            
            
            self.view.makeToast("Facebook signup")
            
            
            if let accessToken = AccessToken.current {
                // User is logged in, use 'accessToken' here.
                print(accessToken.userId!)
                print(accessToken.appId)
                print(accessToken.grantedPermissions!)
                print(accessToken.expirationDate)
                
                let request = GraphRequest(graphPath: "me", parameters: ["fields":"id,email,name,first_name,last_name,picture.type(large)"], accessToken: AccessToken.current, httpMethod: .GET, apiVersion: FacebookCore.GraphAPIVersion.defaultVersion)
                request.start { (response, result) in
                    switch result {
                    case .success(let value):
                        hideLoading(view: self.view)
                        print(value.dictionaryValue!)
                        let myname =    value.dictionaryValue?["name"] as! String
                        let myfbId =  value.dictionaryValue?["id"] as! String
                        
                        
                        
                        let facebookProfile: String = "http://graph.facebook.com/\(myfbId)/picture?type=large"
                        let url: URL = URL(string: facebookProfile)!
                        self.defaltsHlpr.setfbId(myfbId)
                        self.defaltsHlpr.setFbProfilePic(facebookProfile)
                        
                        self.postTestApi(type: "facebook", username: myfbId, info: "", countryCode: "")
                        
                        //self.navigationController?.popViewController(animated: true)
                       // self.dismiss(animated: true, completion: nil)

                    case .failed(let error):
                        print(error)
                    }
                }
                
                //            let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "SVC") as! SecondViewController
                //            self.present(storyboard, animated: true, completion: nil)
            } else {
                
                let loginManager=LoginManager()
                loginManager.loginBehavior = .systemAccount
                loginManager.logIn(readPermissions: [ReadPermission.publicProfile, .email /*.userFriends, .userBirthday*/], viewController : self) { loginResult in
                    switch loginResult {
                    case .failed(let error):
                        print(error)
                    case .cancelled:
                        print("User cancelled login")
                    case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                        print("Logged in : \(grantedPermissions), \n \(declinedPermissions), \n \(accessToken.appId), \n \(accessToken.authenticationToken), \n \(accessToken.expirationDate), \n \(accessToken.userId!), \n \(accessToken.refreshDate), \n \(accessToken.grantedPermissions!)")
                        
                        let request = GraphRequest(graphPath: "me", parameters: ["fields": "id, email, name, first_name, last_name, picture.type(large)"], accessToken: AccessToken.current, httpMethod: .GET, apiVersion: FacebookCore.GraphAPIVersion.defaultVersion)
                        request.start { (response, result) in
                            switch result {
                            case .success(let value):
                                print(value.dictionaryValue!)
                                let mydict  = value.dictionaryValue!
                                let myname = mydict["name"] as? String
                                let myId = mydict["id"] as? String
                                self.defaltsHlpr.setfbId(myId!)
                                print(myname!)
                            case .failed(let error):
                                print(error)
                            }
                        }
                        
                        
                        
                    }
                }
            }

        }
        else
        {
            self.view.makeToast("Check your Connection")
        }

    }
    
    func getUserDetails(){
        
        if(FBSDKAccessToken.current() != nil){
            
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id,name , first_name, last_name , email"]).start(completionHandler: { (connection, result, error) in
                
                guard let Info = result as? [String: Any] else { return }
                
                if let userName = Info["name"] as? String
                {
                    print(userName)
                    print("our required response ",Info)
                }
                
            })
        }
    }
    @IBAction func googlePlusButtonTouchUpInside(sender: AnyObject) {
        
        if Reachability.isConnectedToNetwork() == true {
            
            GIDSignIn.sharedInstance().delegate = self
            GIDSignIn.sharedInstance().uiDelegate = self
            GIDSignIn.sharedInstance().signIn()
        }
        else
        {
            self.view.makeToast("Check Your conncetion")
        }
        
    }
    
   

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user:GIDGoogleUser!, withError error: Error?) {
        
    }
    
    @IBAction func gmailSignup(_ sender: Any) {
        
        self.view.makeToast("Gmail signup")

    }
    
    @IBAction func twitterSignup(_ sender: Any) {
        
        
        let account = ACAccountStore()
        let accountType = account.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
        
        account.requestAccessToAccounts(with: accountType, options: nil, completion: {(success, error) in
            if success {
                if let twitterAccount = account.accounts(with: accountType).last as? ACAccount {
                    print("signed in as \(twitterAccount.username)");
                }
            }
        })
        
        
        
        TWTRTwitter.sharedInstance().logIn {
            (session, error) -> Void in
            if (session != nil) {

                print(session?.userName)
                print(session?.userID)
            } else {
                print(error?.localizedDescription)

            }
        }
        
        self.view.makeToast("Twitter signup")
        

    }
    @IBAction func instaSignup(_ sender: Any) {
        self.view.makeToast("Instagram signup")

    }
    
    
    @IBAction func termsOfUseAction(_ sender: Any) {
        self.view.makeToast("Terms of usage ")
    }
    
    
    @IBAction func privacyPolicyAction(_ sender: Any) {
         self.view.makeToast("Privacy policy")
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func postTestApi(type: String , username:String ,info:String , countryCode:String )  {
        let url = URL(string: "http://68.183.81.213:4200/api/v1/users/socialRegistration")!
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let coordinate = Coordinate(id: "", type: type , username: username, info: info, countryCode: countryCode)
        // set this however you want
        request.httpBody = try! JSONEncoder().encode(coordinate)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                print(error ?? "Unknown error")
                 hideLoading(view: self.view)
                return
            }
            
            do {
                let responseObject = try JSONSerialization.jsonObject(with: data)
                let jsonDecoder = JSONDecoder()
                
                print(responseObject)
                self.mobileData = try
                    jsonDecoder.decode(signupMobileData.self, from: data)
                
                
                if(self.mobileData?.data1?.status == 1)
                {

                    print(self.mobileData?.message as Any)

                    DispatchQueue.main.async {
                        // Update UI
                        hideLoading(view: self.view)
                        self.navigationController?.popViewController(animated: true)
                    }

                }
                else
                {
                     hideLoading(view: self.view)
                    self.view.makeToast("Server error")
                }
                
                
                print(responseObject)
            } catch let parseError {
                 hideLoading(view: self.view)
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
