//
//  MemoryBookVideoHelper.swift
//  MyCompanion
//
//  Created by Julia Pohlmann on 4/28/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import AVFoundation

class MemoryBookVideoHelper {
    
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
    
    static func setVideoThumbnail(videoURL: URL, imageView: UIImageView!) {
//        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
//        let documentsDirectory = paths[0]
//        let videoURL = URL(fileURLWithPath: documentsDirectory + "/" + (page?.value(forKeyPath: "videoID") as! String))
        
        let asset = AVURLAsset(url: videoURL, options: nil)
        let imgGenerator = AVAssetImageGenerator(asset: asset)
        
        do {
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(0, 1), actualTime: nil)
            imageView.image = UIImage(cgImage: cgImage)
        } catch {
            print(error)
        }
    }
    
    static func setStockPhoto(imageView: UIImageView) {
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.black.cgColor
        if(imageView.image == nil) {
            imageView.image = UIImage.fontAwesomeIcon(name: .camera, textColor: UIColor.black, size: CGSize(width: 128, height: 128))
        }
    }
    
    // thanks http://stackoverflow.com/questions/36536044/swift-video-to-document-directory

    static func writeVideoToDocument(videoURL: NSURL!, videoID: String) -> String {
        var tempVideoID = videoID
        let uniqueID = NSUUID().uuidString
        let myVideoVarData = try! Data(contentsOf: videoURL! as URL)
        
        //data to temp directory
        let tempPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let tempDocumentsDirectory: AnyObject = tempPath[0] as AnyObject
        tempVideoID = uniqueID  + "TEMPVIDEO.MOV"
        
        let tempDataPath = tempDocumentsDirectory.appendingPathComponent(tempVideoID) as String
        try? myVideoVarData.write(to: URL(fileURLWithPath: tempDataPath), options: [])
        
        //Now we remove the data from the temp Document Diroctory.
        do{
            let fileManager = FileManager.default
            try fileManager.removeItem(atPath: tempDataPath)
        } catch {
            //Do nothing
        }
        
        //Here we are writing the data to the Document Directory for use later on.
        let docPaths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentsDirectory: AnyObject = docPaths[0] as AnyObject
        tempVideoID = uniqueID  + "VIDEO.MOV"
        let docDataPath = documentsDirectory.appendingPathComponent(tempVideoID) as String
        try? myVideoVarData.write(to: URL(fileURLWithPath: docDataPath), options: [])
        
        return tempVideoID

    }
    
    
    
    
    
    
    
}
