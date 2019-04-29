//
//  homeTabViewController.swift
//  tiktok
//
//  Created by Bharat shankar on 18/02/19.
//  Copyright © 2019 Bharat shankar. All rights reserved.
//

import UIKit
import MobileCoreServices

class homeTabViewController: UITabBarController,UITabBarControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate  {
    
    var controller = UIImagePickerController()
    let videoFileName = "/video.mp4"
    
    var isloggedin = true
    let button = UIButton.init(type: .custom)
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // UITabBar.appearance().barTintColor = UIColor.clear
        let appearance = UITabBarItem.appearance(whenContainedInInstancesOf: [homeTabViewController.self])
        appearance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        appearance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.yellow], for: .selected)
        
        self.delegate = self
        
        button.setImage(UIImage(named: "addvideo-72"), for: .normal )
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.yellow, for: .highlighted)
        button.addTarget(self, action: #selector(self.pressButton(_:)), for: .touchUpInside) //<- use `#selector(...)`

        
        button.layer.cornerRadius = 32

        self.view.insertSubview(button, aboveSubview: self.tabBar)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.showSpinningWheel(_:)), name: NSNotification.Name(rawValue: "MiddlebTnHide"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.middleButtonAction(_:)), name: NSNotification.Name(rawValue: "middleButton"), object: nil)

        //UITabBar.appearance().barTintColor = UIColor.clear

        // Do any additional setup after loading the view.
    }
    
    
    
    //The target function of midle button
    @objc func pressButton(_ sender: UIButton){ //<- needs `@objc`
   
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "forPalyerPausedNoti"), object: nil, userInfo: nil)
        
        let mycamPage = storyboard?.instantiateViewController(withIdentifier: "myVideoView") as! myVideoView
        
        self.present(mycamPage, animated: true, completion: nil)
        
//        let imagePickerController = UIImagePickerController()
//        imagePickerController.delegate = self
//        imagePickerController.sourceType = .camera
//        imagePickerController.mediaTypes = [kUTTypeMovie as String]
//        self.present(imagePickerController, animated: true, completion: nil)

    }

    
    
    
    // handle notification
    @objc func showSpinningWheel(_ notification: NSNotification) {
        
        self.button.isHidden = true
        
    }
    
    @objc func middleButtonAction(_ notification: NSNotification) {
        
        self.button.isHidden = false
        
    }
    
    @IBAction func videoBtn(_ sender: Any) {
        
    }
    
//    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let selectedVideo:URL = (info[UIImagePickerController.InfoKey.mediaURL] as? URL) {
//            // Save video to the main photo album
//            let selectorToCall = #selector(videoViewController.videoSaved(_:didFinishSavingWithError:context:))
//            UISaveVideoAtPathToSavedPhotosAlbum(selectedVideo.relativePath, self, selectorToCall, nil)
//            
//            // Save the video to the app directory so we can play it later
//            let videoData = try? Data(contentsOf: selectedVideo)
//            let paths = NSSearchPathForDirectoriesInDomains(
//                FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
//            let documentsDirectory: URL = URL(fileURLWithPath: paths[0])
//            let dataPath = documentsDirectory.appendingPathComponent(videoFileName)
//            try! videoData?.write(to: dataPath, options: [])
//        }
//        picker.dismiss(animated: true)
//    }
//    
//    @objc func videoSaved(_ video: String, didFinishSavingWithError error: NSError!, context: UnsafeMutableRawPointer){
//        if let theError = error {
//            print("error saving the video = \(theError)")
//        } else {
//            DispatchQueue.main.async(execute: { () -> Void in
//            })
//        }
//    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // safe place to set the frame of button manually
        button.frame = CGRect.init(x: self.tabBar.center.x - 32, y: self.view.bounds.height - 74, width: 64, height: 64)
    }
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        var myBoolResult : Bool
        
        
        if (viewController == tabBarController.viewControllers?[2] )
        {


            
            return false
        }
        else if (viewController == tabBarController.viewControllers?[4] )
        {

            
            
                if(DEFAULT_HELPER.getId() != "")
                {
                    if(DEFAULT_HELPER.getId().isEmpty == true)
                    {
                        DispatchQueue.main.async {
                            NotificationCenter.default.post(name: Notification.Name(VIDEO_PLAYER_PAUSE), object: nil)

                            let popupNavController = self.storyboard?.instantiateViewController(withIdentifier: "ExampleNavigationController") as? ExampleNavigationController
                            popupNavController!.height = 600
                            popupNavController!.topCornerRadius = 15
                            popupNavController!.presentDuration = 0.3
                            popupNavController!.dismissDuration = 0.3
                            popupNavController!.shouldDismissInteractivelty = true
                            self.present(popupNavController!, animated: true, completion: nil)
                           
                        }
                        myBoolResult = false
                        return false
                    }
                    else
                    {
                        myBoolResult = true
                        return true
                    }
                    

                }
                else if(DEFAULT_HELPER.getfbId() == "")
                {
                    if(DEFAULT_HELPER.getfbId().isEmpty == true)
                    {
                        DispatchQueue.main.async {
                            let popupNavController = self.storyboard?.instantiateViewController(withIdentifier: "ExampleNavigationController") as? ExampleNavigationController
                            popupNavController!.height = 600
                            popupNavController!.topCornerRadius = 15
                            popupNavController!.presentDuration = 0.3
                            popupNavController!.dismissDuration = 0.3
                            popupNavController!.shouldDismissInteractivelty = true
                            self.present(popupNavController!, animated: true, completion: nil)
                            
                        }
                        myBoolResult = false
                        return false
                    }else
                    {
                        
                        
                       return true
                    }
                    
                }
                
            
        
            
            
        }
        
            return true
        
    }
    
    
    

}


extension homeTabViewController: BottomPopupDelegate {
    
    func bottomPopupViewLoaded() {
        print("bottomPopupViewLoaded")
    }
    
    func bottomPopupWillAppear() {
        print("bottomPopupWillAppear")
    }
    
    func bottomPopupDidAppear() {
        print("bottomPopupDidAppear")
    }
    
    func bottomPopupWillDismiss() {
        print("bottomPopupWillDismiss")
    }
    
    func bottomPopupDidDismiss() {
        print("bottomPopupDidDismiss")
    }
    
    func bottomPopupDismissInteractionPercentChanged(from oldValue: CGFloat, to newValue: CGFloat) {
        print("bottomPopupDismissInteractionPercentChanged fromValue: \(oldValue) to: \(newValue)")
    }
}
