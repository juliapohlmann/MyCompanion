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
        
        var label : UILabel
        
        var imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        print("TEMPLATE TYPE \(templateType)")
        
        //photo
        if(templateType.hasSuffix("P")) {
            let image = UIImage(data: imageData! as Data)
            imageView = UIImageView(image: image!)
        } else {
            //video
            //makes thumbnail
            let videoURL = getFilePathURL()
            let asset = AVURLAsset(url: videoURL as URL, options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            
            do {
                let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(0, 1), actualTime: nil)
                imageView.image = UIImage(cgImage: cgImage)
                
                let playImage = UIImage(named: "play-btn.png")
                let playImageView = UIImageView(image:playImage)
                playImageView.frame = CGRect(x: 75, y: 75, width: 100, height: 100)
                imageView.addSubview(playImageView)
                
                let singleTap = UITapGestureRecognizer(target: self, action: #selector(PhotoPageViewController.tapDetected))
                singleTap.numberOfTapsRequired = 1
                imageView.isUserInteractionEnabled = true
                imageView.addGestureRecognizer(singleTap)
                
            } catch {
                print(error)
            }
            
        }
        
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
        
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 30)
        label.text = pageText
        label.numberOfLines = 100
        self.view.addSubview(label)
        
        view.addSubview(imageView)
        
        
    }


}
