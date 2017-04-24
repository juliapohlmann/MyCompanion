//
//  LabelPageViewController.swift
//  MyCompanion
//
//  Created by Shyam Kotak on 3/27/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import UIKit

class LabelPageViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    
    var pageText : String = ""
    var pageTitle : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //titleLabel.text = pageTitle
        //textLabel.text = pageText
        
        if let titleLabel = self.view.viewWithTag(1) as? UILabel {
            titleLabel.text = pageTitle
        }
        
        if let textLabel = self.view.viewWithTag(2) as? UILabel {
            textLabel.text = pageText
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
