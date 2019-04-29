//
//  Tab2VC.swift
//  Tabbar
//
//  Created by Ketan on 7/26/17.
//  Copyright © 2017 kETANpATEL. All rights reserved.
//

import UIKit
import Photos
import PhotosUI
import AVFoundation


class Tab2VC: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource {

    var arrOfVideos = [AVPlayerItem]()
    var myVideoThumBs = [UIImage]()
    var timeArray = [TimeInterval]()
    var thumbImagesArray = [UIImage]()
    
    
    @IBOutlet weak var myVideoCollection: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showLoading(view: self.view)
        
        // this is to set collectionview cells size perferfectly fit
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: self.view.frame.size.width/3, height: self.view.frame.size.width/3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        myVideoCollection!.collectionViewLayout = layout
        
        
        DispatchQueue.global(qos: .background).async {
            
            PHPhotoLibrary.requestAuthorization { (status) -> Void in
                
                let allVidOptions = PHFetchOptions()
                
                
                allVidOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.video.rawValue) //Any type you want to fetch
                allVidOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
                
                
                //Now the set the option to `fetchAssets`
                let allVids = PHAsset.fetchAssets(with: .video, options: allVidOptions)
                
                print("All Videos Count \(allVids.count)")
                
                
                
                let manager = PHImageManager.default()
                let option = PHImageRequestOptions()
                var thumbnail = UIImage()
                option.isSynchronous = true
                for index in 0..<allVids.count {
                    
                    
                    
                    PHImageManager.default().requestImageData(for: allVids[index] , options: PHImageRequestOptions(), resultHandler:
                        {
                            (imagedata, dataUTI, orientation, info) in
                            if info!.keys.contains(NSString(string: "PHImageFileURLKey"))
                            {
                                let path = info![NSString(string: "PHImageFileURLKey")] as! NSURL
                                print("mypath is ",path)
                                
                            }
                    })
                }
                for index in 0..<allVids.count {
                    
                    manager.requestImage(for: allVids[index] as! PHAsset, targetSize: CGSize(width: 138, height: 138), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
                        thumbnail = result!
                        
                        self.myVideoThumBs.append(thumbnail)
                        print(index)
                        
                        //                    let  videoSingleObject = allVids[index] as! PHAsset
                        //                    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
                        //                    let url = NSURL(fileURLWithPath: path)
                        //                  print(url.absoluteURL)
                        
                        
                        
                    })
                }
                //DispatchQueue.main.async {
                
                
                
                
                
                
                //}
                
                for index in 0..<allVids.count {
                    
                    let videoRequestOptions =           PHVideoRequestOptions()
                    videoRequestOptions.deliveryMode = .automatic //quality-> 360p mp4
                    videoRequestOptions.version =      .current
                    
                    let myasset = allVids[index] as PHAsset
                    print("ghgjjh",myasset.duration)
                    
                    self.timeArray.append(myasset.duration)
                    
                    PHImageManager.default().requestPlayerItem(forVideo: allVids[index], options: videoRequestOptions , resultHandler: { (playerItem, result) in
                        
                        //                         print(result)
                        //                      print(playerItem?.duration)
                        print(playerItem?.asset)
                        
                        if (playerItem?.asset) != nil{
                            let currentVideoUrlAsset = playerItem?.asset as?  AVURLAsset
                            
                            let currentVideoFilePAth = currentVideoUrlAsset!.url
                            print("my video destionation ",currentVideoFilePAth)
                            print("my duration is ", self.getMediaDuration(url: currentVideoFilePAth as NSURL))
                        }
                        
                        
                        //
                        //                        let lastObject = currentVideoFilePAth.pathExtension
                        //
                        //                        print(lastObject)
                        //
                        //                        if lastObject == "M4V" {
                        //
                        //                            self.arrOfVideos.append(playerItem!)
                        //
                        //                        }
                        //
                        //
                        //                        //NSString *lastPath = [videoURL lastPathComponent];
                        //                        //NSString *fileExtension = [lastPath pathExtension];
                        //                        //NSLog(@"File extension %@",fileExtension);
                        //
                        //
                        //                        var i = Int()
                        //                        print("Appending.... \(i);)")
                        //                        i += 1
                        //
                        //                        print("My Videos Count \(self.arrOfVideos.count)")
                        //
                        //
                        //                        DispatchQueue.main.async(execute: {
                        //
                        //
                        //                        })
                        
                    })
                    
                    //fetch Asset here
                    //print(allVids[index].description)
                    //   print(self.arrOfVideos) //will show empty first then after above completion the execution will come here again
                    
                }
                
                DispatchQueue.main.async(execute: {
                    
                    self.myVideoCollection.reloadData()
                })
                
            }
            
        }
        
    }

    
    override func viewDidAppear(_ animated: Bool) {
        hideLoading(view: self.view)
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
     {
        return self.myVideoThumBs.count
    }
    
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
     {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imagesCollectionViewCell", for: indexPath) as! imagesCollectionViewCell
        
        cell.imagesCell.image = self.myVideoThumBs[indexPath.row]
        
        cell.durationLbl.text = self.timeArray[indexPath.row].stringFromTimeInterval()
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 160.0, height: 160.0)
    }
    
    
    
    func getMediaDuration(url: NSURL!) -> Float64{
        let asset : AVURLAsset = AVURLAsset(url: url as URL) as AVURLAsset
        let duration : CMTime = asset.duration
        return CMTimeGetSeconds(duration)
    }
    
    
    
    
    
    
    func postCall(url : String , myuserId : String){
        
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        let postString = "userId=\(myuserId)"
        
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            do {
                
                if let responseJSON = try JSONSerialization.jsonObject(with: data!) as? [String:AnyObject]{
                    print(responseJSON)
                    
                    
                }
            }
            catch {
                print("Error -> \(error)")
            }
            
            
            
        }
        
        
        task.resume()
        
        
        
    }

}
extension TimeInterval{
    
    func stringFromTimeInterval() -> String {
        
        let time = NSInteger(self)
        
        let ms = Int((self.truncatingRemainder(dividingBy: 1)) * 1000)
        let seconds = time % 60
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        
        return String(format: "%0.2d:%0.2d:%0.2d",hours,minutes,seconds)
        
    }
}
