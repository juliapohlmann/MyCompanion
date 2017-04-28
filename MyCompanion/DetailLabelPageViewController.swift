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

class DetailLabelPageViewController: UIViewController, UITextFieldDelegate {
    
    var vcType : String = ""
    var page : NSManagedObject?

    var templateType: String = ""
    var videoID: String = ""
    @IBOutlet var titleTextField: HoshiTextField!
    @IBOutlet var textTextField: HoshiTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(vcType == "Edit Page") {
            setPageFields()
        }
        titleTextField.delegate = self
        textTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    /**
        Helper function telling whether to return once editing is done
     
        - Parameter textField: textField to return from
        - Returns: whether to return after editing ended
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func setPageFields() {
        titleTextField.text = page?.value(forKeyPath: "title") as? String
        textTextField.text = page?.value(forKeyPath: "text") as? String
    }
    
    // MARK: Core Data
    @IBAction func storePage(_ sender: Any) {
        if vcType == "Add Page" {
            let didStorePage = MemoryBookDataManager.storePage(title: titleTextField.text, text: textTextField.text, templateType: self.templateType, imageData: nil, videoID: self.videoID)
            if didStorePage {
                performSegue(withIdentifier: "addLabelPageToEditMemoryBook", sender: self)
            }
        } else if vcType == "Edit Page" {
            let didUpdatePage = MemoryBookDataManager.updatePage(page: page!, title: titleTextField.text, text: nil, templateType: self.templateType, imageData: nil, videoID: self.videoID)
            if didUpdatePage {
                performSegue(withIdentifier: "addLabelPageToEditMemoryBook", sender: self)
            }
        }
    }


}
