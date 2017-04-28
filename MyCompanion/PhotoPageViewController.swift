//
//  PhotoPageViewController.swift
//  MyCompanion
//
//  Created by Shyam Kotak on 3/27/17.
//  Copyright © 2017 EECS395. All rights reserved.
//


import UIKit
import AVFoundation
import AVKit

class PhotoPageViewController: UIViewController {
    
    var templateType : String = ""
    var pageTitle : String = ""
    var pageText : String = ""
    var imageData : NSData? = nil
    var videoID : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func getFilePathURL() -> URL{
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        let videoDataPath = documentsDirectory + "/" + videoID
        return URL(fileURLWithPath: videoDataPath)
    }
    
    func tapDetected() {
        let player = AVPlayer(url: getFilePathURL())
        let playerController = AVPlayerViewController()
        playerController.player = player
        self.present(playerController, animated: true) {
            player.play()
        }
    }
    
    func setupView() {
        
        if let titleLabel = self.view.viewWithTag(1) as? UILabel {
            titleLabel.text = pageTitle
        }
        
        if(templateType.hasSuffix("P")) {
            
            if let imageView = self.view.viewWithTag(10) as? UIImageView {
                imageView.image = UIImage(data: imageData! as Data)
            }
            
        } else {
            
            //makes thumbnail
            let videoURL = getFilePathURL()
            let asset = AVURLAsset(url: videoURL as URL, options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            
            do {
                let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(0, 1), actualTime: nil)
                if let imageView = self.view.viewWithTag(10) as? UIImageView {
                    imageView.image = UIImage(cgImage: cgImage)
                    
                    let playImage = UIImage(named: "play-btn.png")
                    let playImageView = UIImageView(image:playImage)
                    playImageView.frame = CGRect(x: 75, y: 75, width: 100, height: 100)
                    imageView.addSubview(playImageView)
                    
                    let singleTap = UITapGestureRecognizer(target: self, action: #selector(PhotoPageViewController.tapDetected))
                    singleTap.numberOfTapsRequired = 1
                    imageView.isUserInteractionEnabled = true
                    imageView.addGestureRecognizer(singleTap)
                }
                
            } catch {
                print(error)
            }
        }
    }

}
