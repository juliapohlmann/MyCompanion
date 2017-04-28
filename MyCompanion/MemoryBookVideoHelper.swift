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
    
    /**
        Helper function that takes a video URL and makes a thumbnail from the image at 0,1
     
        - Parameter videoURL: nsurl video is at
        - Parameter imageView: imageView to add thumbnail as image to
     */
    static func setVideoThumbnail(videoURL: URL, imageView: UIImageView!) {
        let asset = AVURLAsset(url: videoURL, options: nil)
        let imgGenerator = AVAssetImageGenerator(asset: asset)
        
        do {
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(0, 1), actualTime: nil)
            imageView.image = UIImage(cgImage: cgImage)
        } catch {
            print(error)
        }
    }
    
    /**
        Helper function that sets a stock image in the given image view
     
        - Parameter imageView: imageView to add stock photo as image to
     */
    static func setStockPhoto(imageView: UIImageView) {
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.black.cgColor
        if(imageView.image == nil) {
            imageView.image = UIImage.fontAwesomeIcon(name: .camera, textColor: UIColor.black, size: CGSize(width: 128, height: 128))
        }
    }
    
    /**
        Helper function to write the given data to file manager so it can be accessed when veiwing the memory book
        Modeled after an example on: http://stackoverflow.com/questions/36536044/swift-video-to-document-directory
     
        - Parameter videoURL: nsurl to write to document
        - Parameter videoID: string of id to add it at
     
        - Returns: updated videoID string
     */
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
        
        //remove data from temp directory to prepare to write it for real
        do{
            let fileManager = FileManager.default
            try fileManager.removeItem(atPath: tempDataPath)
        } catch {
            print("Error removing temp item")
        }
        
        //add data so we can access it in memory book viewer
        let docPaths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentsDirectory: AnyObject = docPaths[0] as AnyObject
        tempVideoID = uniqueID  + "VIDEO.MOV"
        let docDataPath = documentsDirectory.appendingPathComponent(tempVideoID) as String
        try? myVideoVarData.write(to: URL(fileURLWithPath: docDataPath), options: [])
        
        return tempVideoID

    }
}
