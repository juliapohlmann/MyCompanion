//
//  CaregiverTileViewController.swift
//  MyCompanion
//
//  Created by Julia Pohlmann on 2/21/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import Foundation
import UIKit

class CaregiverTileViewController: UIViewController {
    
    @IBOutlet var caregiverImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        caregiverImage.image = UIImage.fontAwesomeIcon(name: .cog, textColor: UIColor.black, size: CGSize(width: 128, height: 128))
    }
    
    @IBAction func caregiverPortalClick(_ sender: Any) {
        performSegue(withIdentifier: "caregiverTileToCaregiverPageSegue", sender: sender)
    }
    
}
