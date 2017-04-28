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
    
    func tapDetected() {
        let player = AVPlayer(url: MemoryBookPageHelper.getFilePathURL(videoID: videoID))
        let playerController = AVPlayerViewController()
        playerController.player = player
        self.present(playerController, animated: true) {
            player.play()
        }
    }
    
    /**
        Helper function to set up the picture and text label
     
     */
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
            let videoURL = MemoryBookPageHelper.getFilePathURL(videoID: videoID)
            let asset = AVURLAsset(url: videoURL as URL, options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            
            do {
                let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(0, 1), actualTime: nil)
                if let imageView = self.view.viewWithTag(10) as? UIImageView {
                    imageView.image = UIImage(cgImage: cgImage)
                    
                    MemoryBookPageHelper.addPlayButtonToView(imageView: imageView)
                    
                    MemoryBookPageHelper.addTapRecognizer(sender: self, type: "PhotoPageViewController", imageView: imageView)
                }
            } catch {
                print(error)
            }
        }
    }

}
