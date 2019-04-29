//
//  songSelectVC.swift
//  tiktok
//
//  Created by Bharat shankar on 02/04/19.
//  Copyright © 2019 Bharat shankar. All rights reserved.
//

import UIKit
import AVFoundation


class songSelectVC: BottomPopupViewController  , UITableViewDelegate , UITableViewDataSource  ,AVAudioPlayerDelegate {

    
    var height: CGFloat?
    var topCornerRadius: CGFloat?
    var presentDuration: Double?
    var dismissDuration: Double?
    var shouldDismissInteractivelty: Bool?
    var player: AVPlayer?
    var playingOrNot = true
  
    
    @IBOutlet weak var songsTable: UITableView!
    var myAudiosArray = [[String:Any]]()
    
    var audioURL = ""
    var mySongIndex1 : Int?
    var result : Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
         musicAPICall()
    }
    

    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myAudiosArray.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : songsTableViewCell? = (tableView.dequeueReusableCell(withIdentifier: "songsTableViewCell") as! songsTableViewCell)
        if cell == nil {
            cell = (UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "songsTableViewCell") as! songsTableViewCell)
        }
        
        if let eachDix = self.myAudiosArray[indexPath.row] as? [String:Any]
        {
            let mySongName = eachDix["file"] as! String
            
            cell?.songNameLbl.text = mySongName
        }
        
        cell?.selectBtn.tag = indexPath.row
        cell?.selectBtn.addTarget(self, action: #selector(buttonSelected(sender:)), for: UIControl.Event.touchUpInside)
        cell?.songImg.image = #imageLiteral(resourceName: "list-video-gray-72")
        cell?.selectBtn.setImage(UIImage(named: "tick-white-72"), for: .normal)
       
        if self.mySongIndex1 == indexPath.row
        {
            if result == mySongIndex1 && playingOrNot == true
            {
             
             cell?.songImg.image = #imageLiteral(resourceName: "videos-72")
             cell?.selectBtn.setImage(UIImage(named: "profile-check-36"), for: .normal)
             }
            if result == mySongIndex1 && playingOrNot == false
            {
                cell?.songImg.image = #imageLiteral(resourceName: "list-video-gray-72")
                cell?.selectBtn.setImage(UIImage(named: "tick-white-72"), for: .normal)
            }
        else
            {
                cell?.songImg.image = #imageLiteral(resourceName: "videos-72")
                cell?.selectBtn.setImage(UIImage(named: "profile-check-36"), for: .normal)
            }
            
            
        }
        else
        {
             cell?.songImg.image = #imageLiteral(resourceName: "list-video-gray-72")
            cell?.selectBtn.setImage(UIImage(named: "tick-white-72"), for: .normal)

        }
//        if result == mySongIndex1
//        {
//            cell?.audioBtn.setImage(UIImage(named: "tick-white-72"), for: .normal)
//            cell?.selectBtn.setImage(UIImage(named: "tick-white-72"), for: .normal)
//        }
       
        return cell!
    }
    
   
    
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 85
    }
    
    
    @objc func buttonSelected(sender: UIButton){
        
        result = mySongIndex1
        //print(sender.tag)
        
        let button = sender
        let cell = button.superview?.superview as? songsTableViewCell
        let indexPath = self.songsTable.indexPath(for: cell!)
        //print(indexPath?.row)
        self.mySongIndex1 = sender.tag
       
        
        if result != mySongIndex1
        {
           if let eachDix = self.myAudiosArray[indexPath?.row ?? 0] as? [String:Any]
            {
                let mySongName = eachDix["file"] as! String
                
                let url =  self.audioURL + mySongName
                 playingOrNot = true
                self.playSound(myurl: url)
            }
          }
        
        if result == mySongIndex1
        {
            if playingOrNot == true
            {
                print(playingOrNot,"pause")
                player?.pause()
                
                playingOrNot = false
                
                //playingOrNot = true
                //print(result,"pause")
            }
            else
            {
                if let eachDix = self.myAudiosArray[indexPath?.row ?? 0] as? [String:Any]
                {
                    let mySongName = eachDix["file"] as! String
                    let url =  self.audioURL + mySongName
                    print(playingOrNot,"playing")
                    playingOrNot = true
                    self.playSound(myurl: url)
                }
                
            }
            
           }
        
        
//          if result == mySongIndex1
//          {
//           player?.pause()
//          }
        
         self.songsTable.reloadData()
    }
    
    // method to run when table view cell is tapped
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! songsTableViewCell
        
         mySongIndex1 = indexPath.row
        
        if self.mySongIndex1 == indexPath.row {
        
          cell.songImg.image = #imageLiteral(resourceName: "videos-72")
          cell.selectBtn.setImage(UIImage(named: "profile-check-36"), for: .normal)
            
        }
     
        print("You tapped cell number \(indexPath.row)")
        
        if let eachDix = self.myAudiosArray[indexPath.row] as? [String:Any]
        {
            let mySongName = eachDix["file"] as! String
            let url =  self.audioURL + mySongName
            self.playSound(myurl: url)
            playingOrNot = true
            
        }
        
        
          self.songsTable.reloadData()
        
    }
    
    
    func playSound(myurl : String) {
        guard let url = URL.init(string: myurl)else{
            return
        }
        let playerItem = AVPlayerItem.init(url: url)
        player = AVPlayer.init(playerItem: playerItem)
        player?.play()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //player?.pause()
    }
    
    
    func musicAPICall(){
        
        let url = URL(string: "http://testingmadesimple.org/training_app/api/Service/listSongs")!
        
        URLSession.shared.dataTask(with: url, completionHandler: {
            
            (data, response, error) in
            
            if(error != nil){
                
                print("error")
                
            }else{
                
                do{
                    
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! NSDictionary
                    
                    print(json)
                    
                    self.audioURL = json["url"] as! String
                    
                    self.myAudiosArray = json["songs"] as! [[String:Any]]
                    
                    
                    DispatchQueue.main.async {
                        
                        self.songsTable.reloadData()
                    }
                    
                    
                    
                }catch let error as NSError{
                    
                    print(error)
                    
                }
                
            }
            
        }).resume()
        
    }
    
    //MARK: for Popup
    // Bottom popup attribute methods
    // You can override the desired method to change appearance
    
    override func getPopupHeight() -> CGFloat {
        return height ?? CGFloat(300)
    }
    
    override func getPopupTopCornerRadius() -> CGFloat {
        return topCornerRadius ?? CGFloat(10)
    }
    
    override func getPopupPresentDuration() -> Double {
        return presentDuration ?? 1.0
    }
    
    override func getPopupDismissDuration() -> Double {
        return dismissDuration ?? 1.0
    }
    
    override func shouldPopupDismissInteractivelty() -> Bool {
        return shouldDismissInteractivelty ?? true
    }
    

}
