//
//  MemoryBookTileViewController.swift
//  MyCompanion
//
//  Created by Julia Pohlmann on 3/5/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import Foundation
import UIKit

class MemoryBookTileViewController: UIViewController {

    @IBOutlet var memoryBookImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memoryBookImage.image = UIImage.fontAwesomeIcon(name: .book, textColor: UIColor.black, size: CGSize(width: 128, height: 128))
    }
}
