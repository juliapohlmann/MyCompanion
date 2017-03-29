//
//  AddPhotoPageViewController.swift
//  MyCompanion
//
//  Created by Shyam Kotak on 3/19/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import UIKit
import TextFieldEffects
import CoreData
import MobileCoreServices
import AVFoundation
import FontAwesome_swift

class AddPhotoPageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var page : NSManagedObject?
    var vcType : String = ""
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleTextField: JiroTextField!
    let imagePicker = LandscapeImagePickerController()
    var imageData: NSData? = nil
    var templateType: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        
        setStockPhoto()
        
        if(vcType == "Edit") {
            setPageFields()
        }
        // Do any additional setup after loading the view.
    }
    
    func setPageFields() {
        titleTextField.text = page?.value(forKeyPath: "title") as? String
        if(page?.value(forKeyPath: "image") != nil) {
            imageView.image = UIImage(data: page?.value(forKeyPath: "image") as! Data)
            imageData = page?.value(forKeyPath: "image") as! Data as NSData?
        }
    }

    func setStockPhoto() {
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.black.cgColor
        if(imageView.image == nil) {
            imageView.image = UIImage.fontAwesomeIcon(name: .camera, textColor: UIColor.black, size: CGSize(width: 128, height: 128))
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loadImageButtonTapped(sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        if(templateType?.characters.last == "P") {
            imagePicker.mediaTypes = [kUTTypeImage as String]
        } else {
            imagePicker.mediaTypes = [kUTTypeMovie as String]
        }
        imagePicker.modalPresentationStyle = .popover
        let presentationController = imagePicker.popoverPresentationController
        presentationController?.sourceView = self.imageView
        
        self.present(imagePicker, animated: true) {}

    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        
        if mediaType.isEqual(to: kUTTypeImage as String) {
            
            // Media is an image
            let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
            imageData = UIImageJPEGRepresentation(pickedImage!, 1) as NSData?
            
        } else if mediaType.isEqual(to: kUTTypeMovie as String) {
            
            // Media is a video
            let videoUrl = info[UIImagePickerControllerMediaURL] as! NSURL
            
            let asset = AVURLAsset(url: videoUrl as URL, options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            
            do {
                let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(0, 1), actualTime: nil)
                imageView.image = UIImage(cgImage: cgImage)
            } catch {
                print(error)
            }
            
            do {
                imageData = try NSData(contentsOf: videoUrl as URL, options: NSData.ReadingOptions())
            } catch {
                print(error)
            }
            
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Core Data
    @IBAction func storePage() {
        if vcType == "Add" {
            let didStorePage = MemoryBookDataManager.storePage(title: titleTextField.text, text: nil, templateType: self.templateType, imageData: self.imageData)
            if didStorePage {
                performSegue(withIdentifier: "addPhotoPageToEditMemoryBook", sender: self)
            }
        } else if vcType == "Edit" {
            let didUpdatePage = MemoryBookDataManager.updatePage(page: page!, title: titleTextField.text, text: nil, templateType: self.templateType, imageData: self.imageData)
            if didUpdatePage {
                performSegue(withIdentifier: "addPhotoPageToEditMemoryBook", sender: self)
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
