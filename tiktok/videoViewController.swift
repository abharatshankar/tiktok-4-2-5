//
//  videoViewController.swift
//  tiktok
//
//  Created by Bharat shankar on 11/03/19.
//  Copyright © 2019 Bharat shankar. All rights reserved.
//

import UIKit
import CameraManager
import CoreLocation

class videoViewController: UIViewController  {
    let cameraManager = CameraManager()
    @IBOutlet weak var headerView: UIView!
    var isstoppedCam = true
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var flashModeImageView: UIImageView!
    @IBOutlet weak var outputImageView: UIImageView!
    @IBOutlet weak var cameraTypeImageView: UIImageView!
    @IBOutlet weak var qualityLabel: UILabel!
    
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var dismissBtn: UIButton!
    @IBOutlet weak var askForPermissionsLabel: UILabel!
    
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var locationButton: UIButton!
    
    
    
    let darkBlue = UIColor(red: 4/255, green: 14/255, blue: 26/255, alpha: 1)
    let lightBlue = UIColor(red: 24/255, green: 125/255, blue: 251/255, alpha: 1)
    let redColor = UIColor(red: 229/255, green: 77/255, blue: 67/255, alpha: 1)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headerView?.isHidden = true
         headerView?.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        middleView?.backgroundColor = UIColor.black.withAlphaComponent(0.3)
         footerView?.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        middleView.layer.cornerRadius = 25
        cameraManager.shouldEnableExposure = true
        
        cameraManager.shouldFlipFrontCameraImage = false
        cameraManager.showAccessPermissionPopupAutomatically = false
        cameraManager.cameraOutputQuality = .low
        cameraManager.recordedDuration
        
        askForPermissionsLabel.isHidden = true
        
        askForPermissionsLabel.textColor = .white
        askForPermissionsLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(askForCameraPermissions))
        askForPermissionsLabel.addGestureRecognizer(tapGesture)
        
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .authorizedAlways, .authorizedWhenInUse:
                self.cameraManager.shouldUseLocationServices = true
                self.locationButton.isHidden = true
            default:
                self.cameraManager.shouldUseLocationServices = false
            }
        }
        
        let currentCameraState = cameraManager.currentCameraStatus()
        
        if currentCameraState == .notDetermined {
            askForPermissionsLabel.isHidden = false
        } else if currentCameraState == .ready {
            addCameraToView()
        } else {
            askForPermissionsLabel.isHidden = false
        }
        
        flashModeImageView.image = UIImage(named: "flash_off")
        if cameraManager.hasFlash {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeFlashMode))
            flashModeImageView.addGestureRecognizer(tapGesture)
        }
        
        outputImageView.image = UIImage(named: "output_video")
        let outputGesture = UITapGestureRecognizer(target: self, action: #selector(outputModeButtonTapped))
        outputImageView.addGestureRecognizer(outputGesture)
        
        cameraTypeImageView.image = UIImage(named: "camera-front-36")
        let cameraTypeGesture = UITapGestureRecognizer(target: self, action: #selector(changeCameraDevice))
        cameraTypeImageView.addGestureRecognizer(cameraTypeGesture)
        
        qualityLabel.isUserInteractionEnabled = true
        let qualityGesture = UITapGestureRecognizer(target: self, action: #selector(changeCameraQuality))
        qualityLabel.addGestureRecognizer(qualityGesture)
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        cameraManager.resumeCaptureSession()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cameraManager.stopCaptureSession()
    }
    
    
    // MARK: - ViewController
    fileprivate func addCameraToView()
    {
        cameraManager.addPreviewLayerToView(cameraView, newCameraOutputMode: CameraOutputMode.videoWithMic)
        cameraManager.showErrorBlock = { [weak self] (erTitle: String, erMessage: String) -> Void in
            
            let alertController = UIAlertController(title: erTitle, message: erMessage, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (alertAction) -> Void in  }))
            
            self?.present(alertController, animated: true, completion: nil)
        }
    }
    
    // MARK: - @IBActions
    

    
    @IBAction func changeFlashMode(_ sender: UIButton) {
        print("flash mode method called")
        switch cameraManager.changeFlashMode() {
        case .off:
            print("flash off")
            flashModeImageView.image = UIImage(named: "flash_off")
        case .on:
            print("flash on")
            flashModeImageView.image = UIImage(named: "flash_on")
        case .auto:
            print("flash automatic")
            flashModeImageView.image = UIImage(named: "flash_auto")
        }
    }
    
    @IBAction func recordButtonTapped(_ sender: UIButton) {
        
        switch cameraManager.cameraOutputMode {
        case .stillImage: break
//            cameraManager.capturePictureWithCompletion({ result in
//                switch result {
//                case .failure:
//                    self.cameraManager.showErrorBlock("Error occurred", "Cannot save picture.")
//                case .success(let content):
//
//                    let vc: ImageViewController? = self.storyboard?.instantiateViewController(withIdentifier: "ImageVC") as? ImageViewController
//                    if let validVC: ImageViewController = vc,
//                        case let capturedImage = content.asImage {
//                        validVC.image = capturedImage
//                        validVC.cameraManager = self.cameraManager
//                        self.navigationController?.pushViewController(validVC, animated: true)
//                    }
//                }
//            })
        case .videoWithMic, .videoOnly:
            cameraButton.isSelected = !cameraButton.isSelected
            cameraButton.setTitle("", for: UIControl.State.selected)
            
            
          //  cameraButton.backgroundColor = cameraButton.isSelected ? redColor : lightBlue
            
           
            
            if sender.isSelected {
                cameraButton.setImage(UIImage(named: "video-72"), for: .selected)
                cameraManager.startRecordingVideo()
                
                _ = Timer.scheduledTimer(withTimeInterval: 15, repeats: false) { timer in
                   // self.dismissButton(self)
                    if(self.isstoppedCam == true)
                    {
                        
                        self.cameraButton.setImage(UIImage(named: "videos-36"), for: .selected)
                        self.cameraManager.stopVideoRecording({ (videoURL, error) -> Void in
                            self.isstoppedCam = false
                            if error != nil {
                                self.cameraManager.showErrorBlock("Error occurred", "Cannot save video.")
                            }
                            let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "videoPreviewViewController") as! videoPreviewViewController
                            videoUrl2 = videoURL!
                            self.present(storyboard, animated: true, completion: nil)
                        })
                    }
                    
                }
                
                
            } else {
                cameraButton.setImage(UIImage(named: "videos-36"), for: .selected)
                cameraManager.stopVideoRecording({ (videoURL, error) -> Void in
                    self.isstoppedCam = false
                    if error != nil {
                        self.cameraManager.showErrorBlock("Error occurred", "Cannot save video.")
                    }
                    let storyboard = self.storyboard?.instantiateViewController(withIdentifier: "videoPreviewViewController") as! videoPreviewViewController
                    videoUrl2 = videoURL!
                    self.present(storyboard, animated: true, completion: nil)
                })
            }
        }
    }
    
    
    
    @IBAction func locateMeButtonTapped(_ sender: Any) {
        cameraManager.shouldUseLocationServices = true
        
        locationButton.isHidden = true
    }
    
    @IBAction func outputModeButtonTapped(_ sender: UIButton) {
        
        cameraManager.cameraOutputMode = cameraManager.cameraOutputMode == CameraOutputMode.videoWithMic ? CameraOutputMode.stillImage : CameraOutputMode.videoWithMic
        switch cameraManager.cameraOutputMode {
        case .stillImage:
            cameraButton.isSelected = false
            cameraButton.backgroundColor = lightBlue
            outputImageView.image = UIImage(named: "output_image")
        case .videoWithMic, .videoOnly:
            outputImageView.image = UIImage(named: "output_video")
        }
    }
    
    @IBAction func changeCameraDevice() {
        cameraManager.cameraDevice = cameraManager.cameraDevice == CameraDevice.front ? CameraDevice.back : CameraDevice.front
    }
    
    @IBAction func askForCameraPermissions() {
        
        self.cameraManager.askUserForCameraPermission({ permissionGranted in
            
            if permissionGranted {
                self.askForPermissionsLabel.isHidden = true
                self.askForPermissionsLabel.alpha = 0
                self.addCameraToView()
            } else {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                } else {
                    // Fallback on earlier versions
                }
            }
        })
    }
    
    @IBAction func changeCameraQuality() {
        
        switch cameraManager.changeQualityMode() {
        case .high:
            qualityLabel.text = "High"
        case .low:
            qualityLabel.text = "Low"
        case .medium:
            qualityLabel.text = "Medium"
        }
    }
    
    
    
    @IBAction func dismissButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func filtersAction(_ sender: Any) {
        
        guard let popupVC = storyboard?.instantiateViewController(withIdentifier: "filterPopViewController") as? filterPopViewController else { return }
        popupVC.height = 500
        popupVC.topCornerRadius = 20
        popupVC.presentDuration = 1
        popupVC.dismissDuration = 1
        popupVC.shouldDismissInteractivelty = true
        popupVC.popupDelegate = self
        present(popupVC, animated: true, completion: nil)
        
    }
    
}


extension videoViewController: BottomPopupDelegate {
    
    func bottomPopupViewLoaded() {
        showLoading(view: self.view)
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
