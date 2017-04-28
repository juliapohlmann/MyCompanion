//
//  LandscapeImagePickerController.swift
//  MyCompanion
//
//  Created by Shyam Kotak on 3/26/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import UIKit

class LandscapeImagePickerController: UIImagePickerController {

    func application(application: UIApplication,
                     supportedInterfaceOrientationsForWindow window: UIWindow?)
        -> UIInterfaceOrientationMask {
            
            return[.landscape, .portrait]
            
    }

}
