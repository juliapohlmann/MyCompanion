//
//  AddLabelPageViewController.swift
//  MyCompanion
//
//  Created by Shyam Kotak on 3/19/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import UIKit
import CoreData
import TextFieldEffects

class DetailLabelPageViewController: UIViewController {
    
    var vcType : String = ""
    var page : NSManagedObject?

    var templateType: String? = nil
    @IBOutlet var titleTextField: JiroTextField!
    @IBOutlet var textTextField: JiroTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(vcType == "Edit") {
            setPageFields()
        }
        // Do any additional setup after loading the view.
    }
    
    func setPageFields() {
        titleTextField.text = page?.value(forKeyPath: "title") as? String
        textTextField.text = page?.value(forKeyPath: "text") as? String
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Core Data
    @IBAction func storePage() {
        if vcType == "Add" {
            let didStorePage = MemoryBookDataManager.storePage(title: titleTextField.text, text: textTextField.text, templateType: self.templateType, imageData: nil)
            if didStorePage {
                performSegue(withIdentifier: "addLabelPageToEditMemoryBook", sender: self)
            }
        } else if vcType == "Edit" {
            let didUpdatePage = MemoryBookDataManager.updatePage(page: page!, title: titleTextField.text, text: nil, templateType: self.templateType, imageData: nil)
            if didUpdatePage {
                performSegue(withIdentifier: "addLabelPageToEditMemoryBook", sender: self)
            }
        }
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
