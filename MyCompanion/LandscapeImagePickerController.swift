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
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
