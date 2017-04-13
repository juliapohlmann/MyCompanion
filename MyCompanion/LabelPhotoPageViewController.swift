//
//  LabelPhotoPageViewController.swift
//  MyCompanion
//
//  Created by Shyam Kotak on 3/27/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import UIKit

class LabelPhotoPageViewController: UIViewController {
    
    var templateType : String = ""
    var pageTitle : String = ""
    var pageText : String = ""
    var imageData : NSData? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupView() {
        
        if let titleLabel = self.view.viewWithTag(1) as? UILabel {
            titleLabel.text = pageTitle
        }
        
        var label : UILabel
        let image = UIImage(data: imageData! as Data)
        let imageView = UIImageView(image: image!)
        
        if(templateType == "11TP") {
            
            label = UILabel(frame: CGRect(x: 20, y: 362, width: 742, height: 268))
            imageView.frame = CGRect(x: 266, y: 104, width: 250, height: 250)
            
        } else if(templateType == "11DP") {
            
            label = UILabel(frame: CGRect(x: 20, y: 104, width: 742, height: 268))
            imageView.frame = CGRect(x: 266, y: 380, width: 250, height: 250)
            
        } else if(templateType == "11RP") {
            
            label = UILabel(frame: CGRect(x: 20, y: 104, width: 484, height: 526))
            imageView.frame = CGRect(x: 512, y: 200, width: 250, height: 250)
            
        }//else if(templateType == "11LP") {
        else {
            
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
