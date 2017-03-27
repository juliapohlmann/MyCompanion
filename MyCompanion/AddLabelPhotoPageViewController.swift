//
//  AddLabelPhotoPageViewController.swift
//  MyCompanion
//
//  Created by Shyam Kotak on 3/17/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import UIKit
import TextFieldEffects
import CoreData
import MobileCoreServices
import AVFoundation
import FontAwesome_swift

class AddLabelPhotoPageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleTextField: JiroTextField!
    @IBOutlet var textTextField: JiroTextField!
    let imagePicker = LandscapeImagePickerController()
    var imageData: NSData? = nil
    var templateType: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        
        print(templateType ?? "mistake")
        
        imageView.image = UIImage.fontAwesomeIcon(name: .camera, textColor: UIColor.black, size: CGSize(width: 128, height: 128))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loadImageButtonTapped(sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        if(templateType?.characters.last == "P") {
            print("pic")
            imagePicker.mediaTypes = [kUTTypeImage as String]
        } else {
            print("video")
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
            
            print("here")
            // Media is an image
            let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
            imageData = UIImageJPEGRepresentation(pickedImage!, 1) as NSData?
            
        } else if mediaType.isEqual(to: kUTTypeMovie as String) {
            
            print("here2")
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
    
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    @IBAction func storePage() {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "MemoryBook", in: context)
        let mb = NSManagedObject(entity: entity!, insertInto: context)
        
        mb.setValue(titleTextField.text, forKey: "title")
        mb.setValue(textTextField.text, forKey: "text")
        mb.setValue(templateType, forKey: "templateType")
        mb.setValue(imageData, forKey: "image")
        
        // popup errors!
//        if(!isValidEmail(testStr: emailTextField.text!)) {
//            print("not valid email")
//        }
//        else if(!isValidNumber(value: numberTextField.text!)) {
//            print("not valid number")
//        }
//        else if(imageData == nil) {
//            print("no picture")
//        }
//        else {
        
            do {
                try context.save()
            } catch let error as NSError {
                let errorDialog = UIAlertController(title: "Error!", message: "Failed to save! \(error): \(error.userInfo)", preferredStyle: .alert)
                errorDialog.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                present(errorDialog, animated: true)
            }
            
            self.dismiss(animated: true)
            
        //}
        
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
