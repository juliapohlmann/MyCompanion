//
//  LabelPageViewController.swift
//  MyCompanion
//
//  Created by Julia Pohlmann on 4/28/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import Foundation
import UIKit

class LabelPageViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var textLabel: UILabel!
    
    var pageText: String = ""
    var pageTitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let titleLabel = self.view.viewWithTag(1) as? UILabel {
            titleLabel.text = pageTitle
        }
        
        if let textLabel = self.view.viewWithTag(2) as? UILabel {
            textLabel.text = pageText
        }
    }
}
