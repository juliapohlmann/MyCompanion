//
//  DisplayTipsViewController.swift
//  MyCompanion
//
//  Created by Shyam Kotak on 4/19/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import UIKit

class DisplayTipsViewController: UIViewController {

    @IBOutlet var textView: UITextView!
    @IBOutlet var titleLabel: UILabel!
    var text = ""
    var tipTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.text = text
        titleLabel.text = tipTitle
    }
}
