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

class DetailLabelPhotoPageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    var vcType : String = ""
    var page : NSManagedObject?
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleTextField: JiroTextField!
    @IBOutlet var textTextField: JiroTextField!
    let imagePicker = LandscapeImagePickerController()
    var imageData: NSData? = nil
    var templateType: String = ""
    var videoID: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        titleTextField.delegate = self
        textTextField.delegate = self
        
        setStockPhoto()
        
        self.navigationItem.title = self.vcType
        
        //if editing a page, make sure to load current values
        if(vcType == "Edit Page") {
            setPageFields()
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    /**
        Helper function to get thumbnail image from video
     
     */
    func setVideoThumbnail(){
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        let videoURL = documentsDirectory + "/" + (page?.value(forKeyPath: "videoID") as! String)
        
        let asset = AVURLAsset(url: URL(fileURLWithPath: videoURL) as URL, options: nil)
        let imgGenerator = AVAssetImageGenerator(asset: asset)
        
        do {
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(0, 1), actualTime: nil)
            imageView.image = UIImage(cgImage: cgImage)
        } catch {
            print(error)
        }
        
    }
    
    /**
        Sets fields of page with current page values for editing page
     
     */
    func setPageFields() {
        titleTextField.text = page?.value(forKeyPath: "title") as? String
        textTextField.text = page?.value(forKeyPath: "text") as? String
        if(page?.value(forKeyPath: "image") != nil) {
            imageView.image = UIImage(data: page?.value(forKeyPath: "image") as! Data)
            imageData = page?.value(forKeyPath: "image") as! Data as NSData?
        } else if(page?.value(forKeyPath: "videoID") != nil) {
            setVideoThumbnail()
        }
    }
    
    /**
        Sets stock image before an image is uploaded
     
     */
    func setStockPhoto() {
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.black.cgColor
        if(imageView.image == nil) {
            imageView.image = UIImage.fontAwesomeIcon(name: .camera, textColor: UIColor.black, size: CGSize(width: 128, height: 128))
        }
    }
    
    /**
        On load image button click, show thumbnail of photo
     
        - Parameter sender: UIButton that was pressed
     
     */
    @IBAction func loadImageButtonTapped(sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        if(templateType.characters.last == "P") {
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
            
            // thanks http://stackoverflow.com/questions/36536044/swift-video-to-document-directory
            // Media is a video
            let uniqueID = NSUUID().uuidString
            
            let videoURL = info[UIImagePickerControllerMediaURL] as? URL as NSURL?
            let myVideoVarData = try! Data(contentsOf: videoURL! as URL)
            
            //Now writing the data to the temp diroctory.
            let tempPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
            let tempDocumentsDirectory: AnyObject = tempPath[0] as AnyObject
            videoID = uniqueID  + "TEMPVIDEO.MOV"
            let tempDataPath = tempDocumentsDirectory.appendingPathComponent(videoID) as String
            try? myVideoVarData.write(to: URL(fileURLWithPath: tempDataPath), options: [])
            
            //Now we remove the data from the temp Document Diroctory.
            do{
                let fileManager = FileManager.default
                try fileManager.removeItem(atPath: tempDataPath)
            } catch {
                //Do nothing
            }
            
            //Here we are writing the data to the Document Directory for use later on.
            let docPaths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
            let documentsDirectory: AnyObject = docPaths[0] as AnyObject
            videoID = uniqueID  + "VIDEO.MOV"
            let docDataPath = documentsDirectory.appendingPathComponent(videoID) as String
            try? myVideoVarData.write(to: URL(fileURLWithPath: docDataPath), options: [])
            print("docDataPath under picker ",docDataPath)
            
            print(docDataPath)
            
            //makes thumbnail
            let asset = AVURLAsset(url: videoURL! as URL, options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            
            do {
                let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(0, 1), actualTime: nil)
                imageView.image = UIImage(cgImage: cgImage)
            } catch {
                print(error)
            }
            //
            //            do {
            //                imageData = try NSData(contentsOf: videoURL! as URL, options: NSData.ReadingOptions())
            //            } catch {
            //                print(error)
            //            }
            //
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    /**
        Dismiss picker once cancelled
     
        - Parameter picker: picker to dismiss
     
     */
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Core Data
    
    /**
        Based on type of vc, whether editing or creating a page, pass data to MemoryBookData
        manager to update and segue
     
     */
    @IBAction func storePage() {
        if vcType == "Add Page" {
            let didStorePage = MemoryBookDataManager.storePage(title: titleTextField.text!, text: textTextField.text!, templateType: self.templateType, imageData: self.imageData, videoID: self.videoID)
            if didStorePage {
                performSegue(withIdentifier: "addLabelPhotoPageToEditMemoryBook", sender: self)
            }
        } else if vcType == "Edit Page" {
            let didUpdatePage = MemoryBookDataManager.updatePage(page: page!, title: titleTextField.text, text: textTextField.text!, templateType: self.templateType, imageData: self.imageData, videoID: self.videoID)
            if didUpdatePage {
                performSegue(withIdentifier: "addLabelPhotoPageToEditMemoryBook", sender: self)
            }
        }
    }


}
