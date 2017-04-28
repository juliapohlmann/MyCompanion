//
//  MemoryBookPageHelper.swift
//  MyCompanion
//
//  Created by Julia Pohlmann on 4/28/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import Foundation
import UIKit


class MemoryBookPageHelper {
    
    /**
        Helper function that gets the video path url
     
        - Parameter videoID: video to find url of
        - Returns: url of video to show
     */
    static func getFilePathURL(videoID: String) -> URL {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        let videoDataPath = documentsDirectory + "/" + videoID
        return URL(fileURLWithPath: videoDataPath)
    }
    
    /**
        Helper function that adds a play button to the given image view
     
        - Parameter imageView: imageView to add play button to
     */
    static func addPlayButtonToView(imageView: UIImageView) {
        let playImage = UIImage(named: "play-btn.png")
        let playImageView = UIImageView(image:playImage)
        playImageView.frame = CGRect(x: 75, y: 75, width: 100, height: 100)
        imageView.addSubview(playImageView)
    }
    
    /**
        Helper function that adds a tap recognizer to the image view
     
        - Parameter sender: View controller that will send the tap recognizer
        - Parameter type: Type of view controller
        - Parameter imageView: imageView to add gesture recognizer to
     */
    static func addTapRecognizer(sender: UIViewController, type: String, imageView: UIImageView) {
        let singleTap : UITapGestureRecognizer
        
        if(type == "PhotoPageViewController") {
            singleTap = UITapGestureRecognizer(target: sender, action: #selector(PhotoPageViewController.tapDetected))
        } else {
            singleTap = UITapGestureRecognizer(target: sender, action: #selector(LabelPhotoPageViewController.tapDetected))
        }
        
        singleTap.numberOfTapsRequired = 1
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(singleTap)
    }
    
//    /**
//     Helper function for when a tap is detected on the video player
//     
//     */
//    static func tapDetected(viewController: UIViewController) {
//        let player = AVPlayer(url: getFilePathURL())
//        let playerController = AVPlayerViewController()
//        playerController.player = player
//        viewController.present(playerController, animated: true) {
//            player.play()
//        }
//    }
}
