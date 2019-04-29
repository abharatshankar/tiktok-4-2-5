//
//  videosCollectionPreviewVC.swift
//  tiktok
//
//  Created by Bharat shankar on 18/04/19.
//  Copyright © 2019 Bharat shankar. All rights reserved.
//

import UIKit

var initialUrl : URL!

class videosCollectionPreviewVC: UIViewController {

    var myVideoUrl: URL!
    
    var myUrlsArray  = [[String : Any]]()
    
    var videoIndex = 0
    
    
    @IBOutlet weak var videoPreviewView: UIView!
    
    fileprivate var player = Player()
    
    // MARK: object lifecycle
    deinit {
        self.player.willMove(toParent: nil)
        self.player.view.removeFromSuperview()
        self.player.removeFromParent()
    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.player.pause()
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.player.playerDelegate = self
        self.player.playbackDelegate = self
        
        self.player.playerView.playerBackgroundColor = .black
        
        self.addChild(self.player)
        self.videoPreviewView.addSubview(self.player.view)
        self.player.didMove(toParent: self)
        self.player.fillMode = PlayerFillMode.resizeAspectFill
        //        let localUrl = Bundle.main.url(forResource: "IMG_3267", withExtension: "MOV")
        //        self.player.url = localUrl
        
        //let tempDic = self.myUrlsArray[0]
        
       // if let templink  = tempDic["video"] as? String{
        
        if let myur = initialUrl{
             self.player.url =  myur
        }else if let myur = self.myVideoUrl{
            self.player.url =  myur
        }
        
        
        //}
        
        //self.myVideoUrl
        
        self.player.playbackLoops = true
        
        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGestureRecognizer(_:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        self.player.view.addGestureRecognizer(tapGestureRecognizer)
        
        let swipeFromRight = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeUp(gesture:)))
        swipeFromRight.direction = UISwipeGestureRecognizer.Direction.up
        self.player.view.addGestureRecognizer(swipeFromRight)
        
        let swipeFromLeft = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeDown(gesture:)))
        swipeFromLeft.direction = UISwipeGestureRecognizer.Direction.down
        self.player.view.addGestureRecognizer(swipeFromLeft)
        
    }
    

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.player.playFromBeginning()
    }
    
    
    
    
    
    
    @objc func didSwipeUp(gesture: UIGestureRecognizer) {
        
        self.videoIndex = self.videoIndex + 1
        if self.videoIndex >= self.myUrlsArray.count {
            self.videoIndex = self.myUrlsArray.count - 1
        }
        
        let mydic = self.myUrlsArray[self.videoIndex]
        
        
        
        if(self.myUrlsArray.count > self.videoIndex )
        {
            DispatchQueue.main.async {
                // self.showLoad()
            }
            if let myvideoName = mydic["video"] as? String{
                self.player.fillMode = PlayerFillMode.resizeAspectFill
                videoUrl = URL(string:TEMP_VIDEO_URL+myvideoName)
                self.player.url = videoUrl
                self.player.playFromBeginning()
            }
            else
            {
                return
            }
            
            

        }
    }
    
    //Swipe gesture selector function
    @objc func didSwipeDown(gesture: UIGestureRecognizer) {
        // Add animation here
        
        DispatchQueue.global(qos: .background).async {
            print("This is run on the background queue")
            
            
            
            if(self.myUrlsArray.count > self.videoIndex )
            {
                
                if(self.videoIndex == 0)
                {
                    self.videoIndex = 0
                }else{
                    self.videoIndex = self.videoIndex - 1
                }
                
                let mydic = self.myUrlsArray[self.videoIndex]
                
                if let myvideoName = mydic["video"] as? String{
                    self.player.fillMode = PlayerFillMode.resizeAspectFill
                    videoUrl = URL(string:"http://159.65.157.210:5080/LiveApp/streams/"+myvideoName)
                    self.player.url = videoUrl
                    self.player.playFromBeginning()
                }
                else
                {
                    return
                }
            }
        }
        
    }

}



extension videosCollectionPreviewVC {
    
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

extension videosCollectionPreviewVC: PlayerDelegate {
    
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

extension videosCollectionPreviewVC: PlayerPlaybackDelegate {
    
    func playerCurrentTimeDidChange(_ player: Player) {
    }
    
    func playerPlaybackWillStartFromBeginning(_ player: Player) {
    }
    
    func playerPlaybackDidEnd(_ player: Player) {
    }
    
    func playerPlaybackWillLoop(_ player: Player) {
    }
    
}

