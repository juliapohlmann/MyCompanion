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
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getFilePathURL() -> URL{
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        let videoDataPath = documentsDirectory + "/" + videoID
        print(videoDataPath)
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
