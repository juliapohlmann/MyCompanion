//
//  IntroViewController.swift
//  MyCompanion
//
//  Created by Julia Pohlmann on 2/15/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import Foundation
import UIKit

class IntroTileViewController: UIViewController {
    var name : String = "Julia"
    
    
    @IBOutlet var helloLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resizeFrame()
        helloLabel.text = "Hello, \(self.name)!"
//        helloLabel.adjustsFontSizeToFitWidth = true

        print(helloLabel.font)
    }
    
    func resizeFrame() {
        var newFrame = self.view.frame
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        newFrame.size.width = (screenWidth - 60) / 2
        newFrame.size.height = (screenHeight - 60) / 2
        
        self.view.frame = newFrame
        helloLabel.frame = newFrame
        print("new width: \(self.view.frame.width)")
        print("new height \(self.view.frame.height)")
    }
    
    
}
