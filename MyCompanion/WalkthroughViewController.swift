//
//  WalkthroughViewController.swift
//  MyCompanion
//
//  Created by Shyam Kotak on 4/23/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import UIKit

class WalkthroughViewController: UIViewController {

    var progress = 0
    
    @IBOutlet var introPic: UIImageView!
    @IBOutlet var introText: UILabel!
    @IBOutlet var previousButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var prevLabel: UILabel!
    @IBOutlet var nextLabel: UILabel!
    @IBOutlet var nextIcon: UIImageView!
    @IBOutlet var prevIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nextIcon.image = UIImage.fontAwesomeIcon(name: .arrowRight, textColor: UIColor.black, size: CGSize(width: 93, height: 81))
        
        prevIcon.image = UIImage.fontAwesomeIcon(name: .arrowLeft, textColor: UIColor.black, size: CGSize(width: 93, height: 81))
        
        updateView()
        
        //do we need more for caching?..
        UserDefaults.standard.set("ipad", forKey: "userPassword")
        
        UserDefaults.standard.set(true, forKey: "canCall")
        UserDefaults.standard.set(true, forKey: "canEmail")
        UserDefaults.standard.set(true, forKey: "showPhoneNumbers")
        UserDefaults.standard.set(true, forKey: "showEmails")
        UserDefaults.standard.set(true, forKey: "resetRemindersDaily")
        UserDefaults.standard.set(Date(),forKey: "lastOpened")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickPrevious(_ sender: Any) {
        
        progress = progress - 1
        updateView()
        
    }
    
    @IBAction func clickNext(_ sender: Any) {
        
        progress = progress + 1
        updateView()
        
    }
    
    func updateView() {
        
        self.previousButton.isHidden = false
        self.nextButton.isHidden = false
        self.prevIcon.isHidden = false
        self.nextIcon.isHidden = false
        self.prevLabel.isHidden = false
        self.nextLabel.isHidden = false
        
        if(progress == 0) {
            
            self.previousButton.isHidden = true
            self.prevIcon.isHidden = true
            self.prevLabel.isHidden = true
            
        }
        
        if(progress == 10) {
            
            self.nextButton.isHidden = true
            self.nextIcon.isHidden = true
            self.nextLabel.isHidden = true
            
        }
        
        if(progress == 0) {
            
            introText.text = "Welcome"
            
            
        } else if(progress == 1) {
            
            introText.text = "Next"
            
        }
        
        
    }

}
