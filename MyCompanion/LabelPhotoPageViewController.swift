//
//  LabelPhotoPageViewController.swift
//  MyCompanion
//
//  Created by Shyam Kotak on 3/27/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class LabelPhotoPageViewController: UIViewController {
    
    var templateType : String = ""
    var pageTitle : String = ""
    var pageText : String = ""
    var imageData : NSData? = nil
    var videoID : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    /**
        Helper method to set up the view of the label photo page view controller
     */
    func setupView() {
        
        if let titleLabel = self.view.viewWithTag(1) as? UILabel {
            titleLabel.text = pageTitle
        }
        
        var imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        //photo
        if(templateType.hasSuffix("P")) {
            let image = UIImage(data: imageData! as Data)
            imageView = UIImageView(image: image!)
        } else {
            //video
            loadVideo(imageView: imageView)
        }
        var label : UILabel
        label = formatImageLocation(imageView: imageView)
        formatLabel(label: label)
        
        self.view.addSubview(label)
        view.addSubview(imageView)
    }
    
    /**
        Called when a tap is detected to start the video player and play the video
     */
    func tapDetected() {
        let player = AVPlayer(url: MemoryBookVideoHelper.getFilePathURL(videoID: videoID))
        let playerController = AVPlayerViewController()
        playerController.player = player
        self.present(playerController, animated: true) {
            player.play()
        }
    }
    
    /**
        Helper function to format the label's font and text and alignment
     
        - Parameter label: label to format
     */
    func formatLabel(label: UILabel) {
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 30)
        label.text = pageText
        label.numberOfLines = 100
    }
    
    /**
        Helper function to format the images location on the page
     
        - Parameter imageView: image to format
        - Returns: label with location and size specified
     */
    func formatImageLocation(imageView: UIImageView) -> UILabel {
        var label : UILabel
        //11T = photo/video top
        if(templateType.hasPrefix("11T")) {
            
            label = UILabel(frame: CGRect(x: 20, y: 362, width: 742, height: 268))
            imageView.frame = CGRect(x: 266, y: 104, width: 250, height: 250)
            
        } else if(templateType.hasPrefix("11D")) {
            //11D = bottom
            label = UILabel(frame: CGRect(x: 20, y: 104, width: 742, height: 268))
            imageView.frame = CGRect(x: 266, y: 380, width: 250, height: 250)
            
        } else if(templateType.hasPrefix("11R")) {
            //11R = right
            label = UILabel(frame: CGRect(x: 20, y: 104, width: 484, height: 526))
            imageView.frame = CGRect(x: 512, y: 200, width: 250, height: 250)
            
        }//else if(templateType == "11LP") {
        else {
            //11L = left
            label = UILabel(frame: CGRect(x: 278, y: 104, width: 484, height: 526))
            imageView.frame = CGRect(x: 20, y: 200, width: 250, height: 250)
            
        }
        
        return label
    }
    
    /**
        Helper function to load the video and format thumbnail
     
        - Parameter imageView: where to show the thumbnail of the video
     */
    func loadVideo(imageView: UIImageView) {
        let videoURL = MemoryBookVideoHelper.getFilePathURL(videoID: videoID)
        let asset = AVURLAsset(url: videoURL as URL, options: nil)
        let imgGenerator = AVAssetImageGenerator(asset: asset)
        
        do {
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(0, 1), actualTime: nil)
            imageView.image = UIImage(cgImage: cgImage)
            
            MemoryBookVideoHelper.addPlayButtonToView(imageView: imageView)
            
            MemoryBookVideoHelper.addTapRecognizer(sender: self, type: "LabelPhotoPageViewController", imageView: imageView)
        } catch {
            print(error)
        }
    }
}
