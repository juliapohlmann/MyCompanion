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
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
