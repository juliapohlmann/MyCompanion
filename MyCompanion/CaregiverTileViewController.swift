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

    @IBAction func caregiverPortalClick(_ sender: Any) {
        performSegue(withIdentifier: "caregiverTileToCaregiverPageSegue", sender: sender)

    }
    
}
