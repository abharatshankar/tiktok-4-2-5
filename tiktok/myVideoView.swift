//
//  myVideoView.swift
//  tiktok
//
//  Created by Bharat shankar on 25/03/19.
//  Copyright © 2019 Bharat shankar. All rights reserved.
//

import UIKit
import Photos
import AVFoundation

class myVideoView: FilterCamViewController {
    
    var player: AVPlayer?
    @IBOutlet weak var uploadPage: UIButton!
    let singletonClass = SingleTon.shared
    @IBOutlet weak var midleView: UIView!
    var isstoppedCam = true
    @IBOutlet weak private var controlPanelView: UIView!
    @IBOutlet weak private var segmentedControl: UISegmentedControl!
    @IBOutlet weak private var torchButton: UIButton!
    @IBOutlet weak private var recordButton: UIButton!
    
    @IBOutlet weak var dismissBtn: UIButton!
    
    
    private let myFilters: [[CIFilter]] = [
        [],
        [CIFilter(name: "CIPhotoEffectInstant")!],
        [CIFilter(name: "CIBumpDistortion")!],
        [ CIFilter(name: "CIPhotoEffectNoir")!],
        [CIFilter(name: "CIBumpDistortionLinear")!],
        [CIFilter(name: "CICircularWrap")!],
        [CIFilter(name: "CIGlassLozenge")!],
        [CIFilter(name: "CIHoleDistortion")!],
        [CIFilter(name: "CIPinchDistortion")!],
        [CIFilter(name: "CITorusLensDistortion")!],
        [CIFilter(name: "CITwirlDistortion")!],
        [CIFilter(name: "CIVortexDistortion")!], //11
        
        
        
        
        [CIFilter(name: "CIColorInvert")!],
        //[CIFilter(name: "CIFalseColor")!],
        [CIFilter(name: "CIMaskToAlpha")!],
        [CIFilter(name: "CIMaximumComponent")!],
        [CIFilter(name: "CIMinimumComponent")!],
        [CIFilter(name: "CIPhotoEffectChrome")!],
        [CIFilter(name: "CIPhotoEffectFade")!],
        [CIFilter(name: "CIPhotoEffectInstant")!],
        [CIFilter(name: "CIPhotoEffectMono")!],
        [CIFilter(name: "CIPhotoEffectNoir")!],
        [CIFilter(name: "CIPhotoEffectProcess")!],
        [CIFilter(name: "CIPhotoEffectTonal")!],
        //[CIFilter(name: "CIPhotoEffectTransfer")!],
        [CIFilter(name: "CISepiaTone")!],
        // [CIFilter(name: "CIVignette")!],
        //[CIFilter(name: "CIVignetteEffect")!],
        
        [CIFilter(name: "CIKaleidoscope")!]
        // [CIFilter(name: "CIOpTile")!]
        
        
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraDelegate = self
        shouldShowDebugLabels = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("filterNotification"), object: nil)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        if let FilNum = notification.userInfo?["filterNumber"] as? String {
            let myNum = Int(FilNum)
            print("selected filter number ",myNum)
            print("filet name ",myFilters[myNum!])
            filters = myFilters[myNum!]
        }
    }
    
    
    @IBAction func filtersAction(_ sender: Any) {
        guard let popupVC = storyboard?.instantiateViewController(withIdentifier: "filterPopViewController") as? filterPopViewController else { return }
        popupVC.height = 200
        popupVC.topCornerRadius = 20
        popupVC.presentDuration = 1
        popupVC.dismissDuration = 1
        popupVC.shouldDismissInteractivelty = true
        popupVC.popupDelegate = self
        present(popupVC, animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func SongsPageAction(_ sender: Any) {
        
        
        if Reachability.isConnectedToNetwork() == true
        {
            
            guard let popupVC = storyboard?.instantiateViewController(withIdentifier: "songSelectVC") as? songSelectVC else { return }
            popupVC.height = self.view.frame.size.height - 100
            popupVC.topCornerRadius = 20
            popupVC.presentDuration = 1
            popupVC.dismissDuration = 0.4
            popupVC.shouldDismissInteractivelty = true
            popupVC.popupDelegate = self
            present(popupVC, animated: true, completion: nil)
        }
        else
        {
            self.view.makeToast("Check your connection")
        }
        
        
    }
    
    
    
    
    
    
    private func saveVideoToPhotos(_ url: URL) {
        let save = {
            PHPhotoLibrary.shared().performChanges({ PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: url) }, completionHandler: { _, _ in
                let fileManager = FileManager.default
                if fileManager.fileExists(atPath: url.path) {
                    
                    let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "videoPreviewViewController") as! videoPreviewViewController
                    videoUrl2 = url
                    self.present(storyboard, animated: true, completion: {
                        try? fileManager.removeItem(at: url)
                    })
                    
                    
                }
            })
        }
        if PHPhotoLibrary.authorizationStatus() != .authorized {
            PHPhotoLibrary.requestAuthorization { status in
                if status == .authorized {
                    save()
                }
            }
        } else {
            save()
        }
        
        
    }
    
    
    
    
    @IBAction func CloseAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func torchButtonAction(_ sender: UIButton) {
        torchLevel = sender.isSelected ? 0 : 1
        sender.isSelected = !sender.isSelected
    }
    
    
    
    
    @IBAction func recordButtonAction(_ sender: UIButton) {
        sender.isSelected ? stopRecording() : startRecording()
        if sender.isSelected == true {
            print("selected")
            
            
            
            self.recordButton.setImage(UIImage(named: "video-72"), for: .normal)
            
            
        }
        else
        {
            
            if (self.singletonClass.myselectedSongUrl as? String) != nil
            {
                if(self.singletonClass.myselectedSongUrl != "")
                {
                    self.playSound(myurl: self.singletonClass.myselectedSongUrl)
                }
            }
            
            print("selected false")
            let jeremyGif = UIImage.gifImageWithName("loader")
            self.recordButton.setImage(jeremyGif, for: .normal)
            
            _ = Timer.scheduledTimer(withTimeInterval: 15, repeats: false) { timer in
                // self.dismissButton(self)
                if(self.isstoppedCam == true)
                {
                    self.recordButton.setImage(UIImage(named: "video-72"), for: .normal)
                    
                    self.isstoppedCam = false
                    
                    self.stopRecording()
                    
                    
                    
                }
            }
        }
        sender.isSelected = !sender.isSelected
    }
    
    
    
    
    @IBAction func uploadAction(_ sender: Any) {
        
        
        DispatchQueue.main.async {
            hideLoading(view: self.view)
            guard let popupVC = self.storyboard?.instantiateViewController(withIdentifier: "audioAndVideosVC") as? audioAndVideosVC else { return }
            popupVC.height = self.view.frame.size.height - 100
            popupVC.topCornerRadius = 20
            popupVC.presentDuration = 0.5
            popupVC.dismissDuration = 0.4
            popupVC.shouldDismissInteractivelty = true
            popupVC.popupDelegate = self
            self.present(popupVC, animated: true, completion: nil)
            
        }
        
    }
    
    
    
    func playSound(myurl : String) {
        
        guard let url = URL.init(string: myurl)else{
            return
        }
        let playerItem = AVPlayerItem.init(url: url)
        player = AVPlayer.init(playerItem: playerItem)
        player?.play()
        
    }
    
    
    
}

extension myVideoView: FilterCamViewControllerDelegate {
    func filterCamDidStartRecording(_ filterCam: FilterCamViewController) {}
    
    func filterCamDidFinishRecording(_ filterCame: FilterCamViewController) {
        
    }
    
    func filterCam(_ filterCam: FilterCamViewController, didFinishWriting outputURL: URL) {
        saveVideoToPhotos(outputURL)
        
    }
    
    func filterCam(_ filterCam: FilterCamViewController, didFocusAtPoint tapPoint: CGPoint) {}
    
    func filterCam(_ filterCam: FilterCamViewController, didFailToRecord error: Error) {}
}



extension myVideoView: BottomPopupDelegate {
    
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
