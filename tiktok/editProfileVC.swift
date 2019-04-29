//
//  editProfileVC.swift
//  tiktok
//
//  Created by Bharat shankar on 12/04/19.
//  Copyright © 2019 Bharat shankar. All rights reserved.
//

import UIKit
import Alamofire

class editProfileVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var editProfileBtn: UIButton!
    
    @IBOutlet weak var saveBtn: UIButton!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var mobileNumberTxtFld: UITextField!
    
    @IBOutlet weak var bioTxtView: UITextView!
    
    var picker = UIImagePickerController();
    
    var myBioData = ""
    var followersCountStr = ""
    var followingCountStr = ""
    var fullnameStr = ""
    var idstr = ""
    var likesStr = ""
    var photoStr = ""
    var videosCountStr = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.profilePic.layer.cornerRadius = self.profilePic.frame.size.width/2
        self.editProfileBtn.layer.cornerRadius = self.editProfileBtn.layer.frame.size.width/2
        
        self.saveBtn.layer.cornerRadius = 15
        
        if(Reachability.isConnectedToNetwork() == true)
        {
            DispatchQueue.main.async {
                showLoading(view: self.view)
            }
            if(DEFAULT_HELPER.getId() != "")
            {
                if(DEFAULT_HELPER.getId().isEmpty == true)
                {
                    self.view.makeToast("Not registered Yet")
                }else
                {
                   self.profilePostCall(url: PROFILE_PAGE, myuserId: DEFAULT_HELPER.getId())
                    
                }
                
            }
            else if(DEFAULT_HELPER.getfbId() != "")
            {
                if(DEFAULT_HELPER.getfbId().isEmpty == true)
                {
                    self.view.makeToast("Not registered Yet")
                }else
                {
                   self.profilePostCall(url: PROFILE_PAGE, myuserId: DEFAULT_HELPER.getId())
                    
                }
                
            }
            
        }
        else
        {
            self.view.makeToast("Check your Connection")
        }
        
        
        
        
    }
    

    
    
    
    
    func profilePostCall(url : String , myuserId : String){
        
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        let postString = "userId=\(myuserId)"
        
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                DispatchQueue.main.async {
                    hideLoading(view: self.view)
                }
                
                print("error=\(error)")
                return
            }
            
            do {
                DispatchQueue.main.async {
                    hideLoading(view: self.view)
                }
                
                if let responseJSON = try JSONSerialization.jsonObject(with: data!) as? [String:AnyObject]{
                    print(responseJSON)
                    
                    
                    
                    if(responseJSON["status"] as! Int == 0)
                    {
                        if let mydata = responseJSON["data"] as? NSDictionary{
                            if let myBio = mydata["bioData"] as? String{
                                self.myBioData = myBio
                            }
                            
                            if let myfollowers = mydata["followers"] as? String{
                                self.followersCountStr = myfollowers
                            }
                            
                            if let myFollowing = mydata["following"] as? String{
                                self.followingCountStr = myFollowing
                            }
                            
                            if let myFullname = mydata["fullName"] as? String{
                                self.fullnameStr = myFullname
                            }
                            
                            if let mylikes = mydata["likes"] as? String{
                                self.likesStr = mylikes
                            }
                            
                            if let myPhotoStr = mydata["photo"] as? String{
                                self.photoStr = myPhotoStr
                            }
                            
                            if let myvideosStr = mydata["videos"] as? String{
                                self.videosCountStr = myvideosStr
                            }
                            
                        }
                        DispatchQueue.main.async {
                            
                            self.nameTextField.text = self.fullnameStr
                            
                            self.bioTxtView.text = self.myBioData
                            
                            self.profilePic.sd_setImage(with: URL(string: DISPLAY_PROFILE_PIC+self.photoStr), placeholderImage: UIImage(named: "user-72"))
                            
                            self.profilePic.layer.cornerRadius = self.profilePic.frame.size.width/2
                            
                            self.profilePic.layer.borderColor = UIColor.white.cgColor
                            
                            self.profilePic.layer.borderWidth = 2
                            
                            self.profilePic.layer.masksToBounds = true
                            
                        }
                        
                        
                        DispatchQueue.main.async {
                            //self.view.makeToast("Something Went Wrong")
                            
                        }
                        
                    }
                    else if(responseJSON["status"] as! Int == 1)
                    {
                        
                        
                    }
                    
                    
                    
                }
            }
            catch {
                print("Error -> \(error)")
                DispatchQueue.main.async {
                    hideLoading(view: self.view)
                }
                
            }
            
            
            
        }
        
        
        task.resume()
        
        
        
    }
    
    
    
    
    
    
    func editProfilePostCall(url : String , myuserId : String , fullName : String , bioData: String){
        
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        let postString = "userId=\(myuserId)&fullName=\(fullName)&bioData=\(bioData)"
        
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                DispatchQueue.main.async {
                    hideLoading(view: self.view)
                }
                
                print("error=\(error)")
                return
            }
            
            do {
                DispatchQueue.main.async {
                    hideLoading(view: self.view)
                }
                
                if let responseJSON = try JSONSerialization.jsonObject(with: data!) as? [String:AnyObject]{
                    print(responseJSON)
                    
                    
                    
                    if(responseJSON["status"] as! Int == 0)
                    {
                        DispatchQueue.main.async {
                            self.view.makeToast("Updated Successfully")
                            self.navigationController?.popViewController(animated: true)
                        }
                        
                    }
                    else if(responseJSON["status"] as! Int == 1)
                    {
                        
                        
                    }
                    
                    
                    
                }
            }
            catch {
                print("Error -> \(error)")
                DispatchQueue.main.async {
                    hideLoading(view: self.view)
                }
                
            }
            
            
            
        }
        
        
        task.resume()
        
        
        
    }
    
    
    
    @IBAction func uploadPicAction(_ sender: Any) {
        let aert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default){
            UIAlertAction in
            self.openCamera()
        }
        let gallaryAction = UIAlertAction(title: "Gallary", style: .default){
            UIAlertAction in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){
            UIAlertAction in
        }
        
        // Add the actions
        self.picker.delegate = self
        aert.addAction(cameraAction)
        aert.addAction(gallaryAction)
        aert.addAction(cancelAction)
        self.present(aert, animated: true, completion: nil)

    }
    
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            picker.sourceType = .camera
            self.present(picker, animated: true, completion: nil)
        } else {
            //            let alertWarning = UIAlertView(title:"Warning", message: "You don't have camera", delegate:nil, cancelButtonTitle:"OK", otherButtonTitles:"")
            //SharedClass.sharedInstance.alertToUser(message: "You don't have camera", inViewCtrl: self)
            alertController(title: "Warning", msg: "You don't have camera")
            
        }
    }
    func openGallery(){
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
            
        }
        self.profilePic.image = image
        self.profilePic.layer.cornerRadius = self.profilePic.frame.size.width/2
        self.profilePic.layer.masksToBounds = true
        self.uploadPicture(myPicture: image)
    }
    
    func alertController (title: String,msg: String) {
        
        let alert = UIAlertController.init(title:title , message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func uploadPicture(myPicture: UIImage) {
        
        var myuid = ""
        
        
        if(DEFAULT_HELPER.getId() != "")
        {
            if(DEFAULT_HELPER.getId().isEmpty == true)
            {
                DispatchQueue.main.async {
                   self.view.makeToast("Not registered Yet")
                    
                }
                
                return
            }else
            {
                myuid = DEFAULT_HELPER.getId()
                
            }
            
        }
        else if(DEFAULT_HELPER.getfbId() != "")
        {
            if(DEFAULT_HELPER.getfbId().isEmpty == true)
            {
                DispatchQueue.main.async {
                    self.view.makeToast("Not registered Yet")
                    
                }
            }else
            {
                myuid = DEFAULT_HELPER.getfbId()
                
            }
            
        }
        else
        {
            return
        }
        
        let parameters: Dictionary<String, Any> = [ "userId" : myuid ]
        DispatchQueue.main.async {
            showLoading(view: self.view)
        }
        
        
        
        let imgData = self.profilePic.image?.jpeg(.lowest)
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData!, withName: "photo",fileName: "file.jpg", mimeType: "image/jpg")
            for (key, value) in parameters {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            } //Optional for extra parameters
        }, to: UPLOAD_PROFILE_PIC, method: .post, headers: ["Content-Type": "multipart/form-data"])
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    print(response.result.value)
//                    let dic = response.result.value as! Dictionary<String,Any>
//                    let status = dic["status"] as? String
//                    let message = dic["message"] as? String
                    
                    DispatchQueue.main.async {
                        hideLoading(view: self.view)
                    }
                    
                    
                }
                
                
                
            case .failure(let encodingError):
                print(encodingError)
            }
        }
        
        
        /*
         SharedClass.sharedInstance.fetchResponseforPerameter(urlStr: UPLOAD_PICUTRE, methodStr: .post, parameters: parameters as [String : AnyObject]) { (response, error) in
         
         if error == nil
         {
         print(response ?? "")
         let status = response!["status"] as? String
         debugPrint("status:\(status ?? "")")
         let message = response!["msg"] as? String
         
         DispatchQueue.main.async {
         SharedClass.sharedInstance.dissMissLoader()
         }
         if (status == "true")
         {
         SharedClass.sharedInstance.alertToUser(message: message!, inViewCtrl: self)
         
         self.status_lbl.text = "Current Status : \(response!["present_status_name"] as? String ?? "")"
         }
         else
         {
         SharedClass.sharedInstance.alertToUser(message: message!, inViewCtrl: self)
         }
         self.detailTbl.reloadData()
         }
         else
         {
         SharedClass.sharedInstance.alertToUser(message: (error?.localizedDescription)!, inViewCtrl: self)
         }
         
         }
         */
        
    }
    
    
    @IBAction func saveAction(_ sender: Any) {
        
        if(DEFAULT_HELPER.getId() != "")
        {
            if(DEFAULT_HELPER.getId().isEmpty == true)
            {
                DispatchQueue.main.async {
                    self.view.makeToast("Not registered Yet")
                    
                }
            }else
            {
                if (self.bioTxtView.text.isEmpty != true)
                {
                    if(self.nameTextField.text?.isEmpty != true){
                        self.editProfilePostCall(url: EDIT_PROFILE_PAGE, myuserId: DEFAULT_HELPER.getId(), fullName: self.nameTextField.text!, bioData: self.bioTxtView.text)
                    }
                    else{
                        DispatchQueue.main.async {
                            self.view.makeToast("Please Update name")
                            
                        }
                    }
                    
                }else
                {
                    DispatchQueue.main.async {
                        self.view.makeToast("Please Update Bio")
                        
                    }
                }
                
               
                
            }
            
        }
        else if(DEFAULT_HELPER.getfbId() != "")
        {
            if(DEFAULT_HELPER.getfbId().isEmpty == true)
            {
                self.view.makeToast("Not registered Yet")
            }else
            {
                if (self.bioTxtView.text.isEmpty != true)
                {
                    if(self.nameTextField.text?.isEmpty != true){
                        self.editProfilePostCall(url: EDIT_PROFILE_PAGE, myuserId: DEFAULT_HELPER.getfbId(), fullName: self.nameTextField.text!, bioData: self.bioTxtView.text)
                    }
                    else{
                        DispatchQueue.main.async {
                            self.view.makeToast("Please Update name")
                            
                        }
                    }
                    
                }else
                {
                    DispatchQueue.main.async {
                        self.view.makeToast("Please Update Bio")
                        
                    }
                }
                
                
            }
            
        }
        
        
        
    }
    

}

extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
}
