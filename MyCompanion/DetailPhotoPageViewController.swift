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

class DetailPhotoPageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    var page : NSManagedObject?
    var vcType : String = ""
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleTextField: JiroTextField!
    let imagePicker = LandscapeImagePickerController()
    var imageData: NSData? = nil
    var videoID: String = ""
    var templateType: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        titleTextField.delegate = self
        
        MemoryBookVideoHelper.setStockPhoto(imageView: imageView)
        
        if(vcType == "Edit Page") {
            setPageFields()
        }
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
//    func setVideoThumbnail(){
//        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
//        let documentsDirectory = paths[0]
//        let videoURL = documentsDirectory + "/" + (page?.value(forKeyPath: "videoID") as! String)
//        
//        let asset = AVURLAsset(url: URL(fileURLWithPath: videoURL) as URL, options: nil)
//        let imgGenerator = AVAssetImageGenerator(asset: asset)
//        
//        do {
//            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(0, 1), actualTime: nil)
//            imageView.image = UIImage(cgImage: cgImage)
//        } catch {
//            print(error)
//        }
//        
//    }
    
    func setPageFields() {
        titleTextField.text = page?.value(forKeyPath: "title") as? String
        if(page?.value(forKeyPath: "image") != nil) {
            print()
            imageView.image = UIImage(data: page?.value(forKeyPath: "image") as! Data)
            imageData = page?.value(forKeyPath: "image") as! Data as NSData?
        } else if(page?.value(forKeyPath: "videoID") != nil) {
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let documentsDirectory = paths[0]
            let videoURL = URL(fileURLWithPath: documentsDirectory + "/" + (page?.value(forKeyPath: "videoID") as! String))
            MemoryBookVideoHelper.setVideoThumbnail(videoURL: videoURL, imageView: imageView)

            videoID = page?.value(forKeyPath: "videoID") as! String
        }
    }

//    func setStockPhoto() {
//        imageView.layer.borderWidth = 2
//        imageView.layer.borderColor = UIColor.black.cgColor
//        if(imageView.image == nil) {
//            imageView.image = UIImage.fontAwesomeIcon(name: .camera, textColor: UIColor.black, size: CGSize(width: 128, height: 128))
//        }
//    }
    
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
            
            // thanks http://stackoverflow.com/questions/36536044/swift-video-to-document-directory
            // Media is a video
            
            let videoURL = info[UIImagePickerControllerMediaURL] as? URL as NSURL?
            videoID = MemoryBookVideoHelper.writeVideoToDocument(videoURL: videoURL, videoID: videoID)
            
            MemoryBookVideoHelper.setVideoThumbnail(videoURL: videoURL as! URL, imageView: imageView)
            
//            let myVideoVarData = try! Data(contentsOf: videoURL! as URL)
//            
//            //Now writing the data to the temp diroctory.
//            let tempPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
//            let tempDocumentsDirectory: AnyObject = tempPath[0] as AnyObject
//            videoID = uniqueID  + "TEMPVIDEO.MOV"
//            let tempDataPath = tempDocumentsDirectory.appendingPathComponent(videoID) as String
//            try? myVideoVarData.write(to: URL(fileURLWithPath: tempDataPath), options: [])
//
//            //Now we remove the data from the temp Document Diroctory.
//            do{
//                let fileManager = FileManager.default
//                try fileManager.removeItem(atPath: tempDataPath)
//            } catch {
//                //Do nothing
//            }
//            
//            //Here we are writing the data to the Document Directory for use later on.
//            let docPaths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
//            let documentsDirectory: AnyObject = docPaths[0] as AnyObject
//            videoID = uniqueID  + "VIDEO.MOV"
//            let docDataPath = documentsDirectory.appendingPathComponent(videoID) as String
//            try? myVideoVarData.write(to: URL(fileURLWithPath: docDataPath), options: [])

            
            //make the thumbnail
//            let asset = AVURLAsset(url: videoURL! as URL, options: nil)
//            let imgGenerator = AVAssetImageGenerator(asset: asset)
//            
//            do {
//                let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(0, 1), actualTime: nil)
//                imageView.image = UIImage(cgImage: cgImage)
//            } catch {
//                print(error)
//            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Core Data
    @IBAction func storePage() {
        if vcType == "Add Page" {
            let didStorePage = MemoryBookDataManager.storePage(title: titleTextField.text, text: nil, templateType: self.templateType, imageData: self.imageData, videoID: self.videoID)
            if didStorePage {
                performSegue(withIdentifier: "addPhotoPageToEditMemoryBook", sender: self)
            }
        } else if vcType == "Edit Page" {
            let didUpdatePage = MemoryBookDataManager.updatePage(page: page!, title: titleTextField.text, text: nil, templateType: self.templateType, imageData: self.imageData, videoID: self.videoID)
            if didUpdatePage {
                performSegue(withIdentifier: "addPhotoPageToEditMemoryBook", sender: self)
            }
        }
    }


}
