//
//  videoPreviewViewController.swift
//  tiktok
//
//  Created by Bharat shankar on 19/03/19.
//  Copyright © 2019 Bharat shankar. All rights reserved.
//

import UIKit
import Alamofire
import Toast_Swift
import AVKit

//var videoUrl2 = URL
var videoUrl2: URL!
let defaultsHelper = DefaultsHelper.init()


class videoPreviewViewController: UIViewController {

    @IBOutlet weak var videoViewPreview: UIView!
    fileprivate var player = Player()
    
    // MARK: object lifecycle
    deinit {
        self.player.willMove(toParent: nil)
        self.player.view.removeFromSuperview()
        self.player.removeFromParent()
    }

    @IBAction func closeAction(_ sender: Any) {
    
    self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
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
        
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.5529411765, green: 0, blue: 0.968627451, alpha: 1)
        
        
        
        
        self.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.player.playerDelegate = self
        self.player.playbackDelegate = self
        
        self.player.playerView.playerBackgroundColor = .black
        
        self.addChild(self.player)
        self.videoViewPreview.addSubview(self.player.view)
        self.player.didMove(toParent: self)
        self.player.fillMode = PlayerFillMode.resizeAspectFill
        //        let localUrl = Bundle.main.url(forResource: "IMG_3267", withExtension: "MOV")
        //        self.player.url = localUrl
        self.player.url = videoUrl2
        
        self.player.playbackLoops = true
        
        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGestureRecognizer(_:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        self.player.view.addGestureRecognizer(tapGestureRecognizer)
        
        // Do any additional setup after loading the view.
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.5529411765, green: 0, blue: 0.968627451, alpha: 1)
        
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.5529411765, green: 0, blue: 0.968627451, alpha: 1)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    
    @objc func buttonAction()
    {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func postVideoBtn(_ sender: Any) {
        
        self.player.pause()
        
        var myId = ""
        
        if defaultsHelper.getfbId().isEmpty != true {
            myId = defaultsHelper.getfbId()
        }
        else if defaultsHelper.getId().isEmpty != true {
            myId = defaultsHelper.getId()
        }
        else
        {
            self.view.makeToast("Please sign up")
            return
        }
        
        encodeVideo(at: videoUrl2, completionHandler: nil)
        
        
    
        
        
        
        
        
//        if myId != "" && myId.isEmpty != true {
//            if let myUrl = videoUrl2
//            {
//                videoPostToServer(videoUrl: myUrl , MyuserId : myId)
//            }
//            else
//            {
//                self.view.makeToast("Video not save properly")
//            }
//        }
//        else
//        {
//            self.view.makeToast("please signup first")
//            return
//        }
        
        
        
    }
    
    
    
    
    
    // Don't forget to import AVKit
    func encodeVideo(at videoURL: URL, completionHandler: ((URL?, Error?) -> Void)?)  {
        let avAsset = AVURLAsset(url: videoURL, options: nil)
        
        let startDate = Date()
        
        //Create Export session
        guard let exportSession = AVAssetExportSession(asset: avAsset, presetName: AVAssetExportPresetPassthrough) else {
            completionHandler?(nil, nil)
            return
        }
        
        //Creating temp path to save the converted video
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] as URL
        let filePath = documentsDirectory.appendingPathComponent("rendered-Video.mp4")
        
        //Check if the file already exists then remove the previous file
        if FileManager.default.fileExists(atPath: filePath.path) {
            do {
                try FileManager.default.removeItem(at: filePath)
            } catch {
                completionHandler?(nil, error)
            }
        }
        
        exportSession.outputURL = filePath
        exportSession.outputFileType = AVFileType.mp4
        exportSession.shouldOptimizeForNetworkUse = true
        let start = CMTimeMakeWithSeconds(0.0, preferredTimescale: 0)
        let range = CMTimeRangeMake(start: start, duration: avAsset.duration)
        exportSession.timeRange = range
        
        exportSession.exportAsynchronously(completionHandler: {() -> Void in
            switch exportSession.status {
            case .failed:
                print(exportSession.error ?? "NO ERROR")
                self.view.makeToast("Processing Video format Error")
                completionHandler?(nil, exportSession.error)
            case .cancelled:
                print("Export canceled")
                self.view.makeToast("Processing Video format Cancelled")
                completionHandler?(nil, nil)
            case .completed:
                //Video conversion finished
                
                if let mythum = self.generateThumbnail(url: videoUrl2){
                     myRecordedThumbNail = mythum
                }else{
                    
                    return
                }
                
               
                
                let endDate = Date()
                
                let time = endDate.timeIntervalSince(startDate)
                print(time)
                print("Successful!")
                videoUrl2 = exportSession.outputURL
                print(exportSession.outputURL ?? "NO OUTPUT URL")
                completionHandler?(exportSession.outputURL, nil)
             DispatchQueue.main.async {
                let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "videoUploadAndTagsVC") as! videoUploadAndTagsVC
                
                self.present(storyboard, animated: true, completion: nil)
                
                }
                
            default: break
            }
            
        })
    }
    
    
    func generateThumbnail(url: URL) -> UIImage? {
        do {
            let asset = AVURLAsset(url: url)
            let imageGenerator = AVAssetImageGenerator(asset: asset)
            imageGenerator.appliesPreferredTrackTransform = true
            
            // Swift 4.2
            let cgImage = try imageGenerator.copyCGImage(at: .zero,
                                                         actualTime: nil)
           
            
            
            return UIImage(cgImage: cgImage)
        } catch {
            print(error.localizedDescription)
            
            return nil
        }
    }
    
    
    
    func videoPostToServer(videoUrl : URL , MyuserId : String)  {
        // showLoading(view: self.view)
        var myuserid = ""
        if defaultsHelper.getId().isEmpty != true {
            myuserid = defaultsHelper.getId()
        }
        else if defaultsHelper.getfbId().isEmpty != true {
            myuserid = defaultsHelper.getfbId()
        }
        else
        {
            self.view.makeToast("Sign up to Post video")
            return
        }
        
//        if self.defaultsHelper.getId().isEmpty != true {
//            myuserid = self.defaultsHelper.getId()
//        }
        let userIDdata = myuserid.data(using: .utf8, allowLossyConversion: true)
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(videoUrl, withName: "video")
            multipartFormData.append(userIDdata!, withName: "userId")
        }, to:"http://68.183.81.213:4200/api/v1/"/*"http://159.65.157.210:5080/LiveApp/rest/broadcast/uploadVoDFile/"*/)
        { (result) in
            switch result {
            case .success(let upload, _ , _):
                upload.uploadProgress(closure: { (progress) in
                   // print(progress)
                    let imageDataDict:[String: String] = ["TotalCount": String(progress.totalUnitCount * 100) , "ActualValue" : String(progress.fractionCompleted * 100) ]
                   
                   print(progress.totalUnitCount)
                    NotificationCenter.default.post(name: Notification.Name("ForProgressBar"), object: nil , userInfo :imageDataDict )

                    print(progress.fractionCompleted)
                })
                upload.responseJSON { response in
                    print(response)
                    print("done")
                    
                    //hideLoading(view: self.view)
                }
            case .failure(let encodingError):
                print("failed")
                print(encodingError)
               // hideLoading(view: self.view)
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.player.playFromBeginning()
    }

}



// MARK: - UIGestureRecognizer

extension videoPreviewViewController {
    
    @objc func handleTapGestureRecognizer(_ gestureRecognizer: UITapGestureRecognizer) {
        switch (self.player.playbackState.rawValue) {
        case PlaybackState.stopped.rawValue:
            self.player.playFromBeginning()
            break
        case PlaybackState.paused.rawValue:
            self.player.playFromCurrentTime()
            break
        case PlaybackState.playing.rawValue:
            self.player.pause()
            break
        case PlaybackState.failed.rawValue:
            self.player.pause()
            break
        default:
            self.player.pause()
            break
        }
    }
    
}

// MARK: - PlayerDelegate

extension videoPreviewViewController: PlayerDelegate {
    
    func playerReady(_ player: Player) {
        print("\(#function) ready")
    }
    
    func playerPlaybackStateDidChange(_ player: Player) {
        print("\(#function) \(player.playbackState.description)")
    }
    
    func playerBufferingStateDidChange(_ player: Player) {
    }
    
    func playerBufferTimeDidChange(_ bufferTime: Double) {
    }
    
    func player(_ player: Player, didFailWithError error: Error?) {
        print("\(#function) error.description")
    }
    
}

// MARK: - PlayerPlaybackDelegate

extension videoPreviewViewController: PlayerPlaybackDelegate {
    
    func playerCurrentTimeDidChange(_ player: Player) {
    }
    
    func playerPlaybackWillStartFromBeginning(_ player: Player) {
    }
    
    func playerPlaybackDidEnd(_ player: Player) {
    }
    
    func playerPlaybackWillLoop(_ player: Player) {
    }
    
}

