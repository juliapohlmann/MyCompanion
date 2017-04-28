//
//  ViewMemoryBookViewController.swift
//  MyCompanion
//
//  Created by Shyam Kotak on 3/27/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import UIKit
import CoreData

class ViewMemoryBookViewController: UIViewController {

    var pages: [NSManagedObject] = []
    var pageNum = 0
    
    @IBOutlet var previousButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var containerView: UIView!
    @IBOutlet var prevLabel: UILabel!
    @IBOutlet var nextLabel: UILabel!
    
    @IBOutlet var nextIcon: UIImageView!
    @IBOutlet var prevIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        nextIcon.image = UIImage.fontAwesomeIcon(name: .arrowRight, textColor: UIColor.black, size: CGSize(width: 93, height: 81))
        prevIcon.image = UIImage.fontAwesomeIcon(name: .arrowLeft, textColor: UIColor.black, size: CGSize(width: 93, height: 81))

        pages = MemoryBookDataManager.fetchPages()
        
        if(pages.count != 0) {
            updateView()
        } else {
            toggleAllPrevious(isHidden: true)
            toggleAllNext(isHidden: true)
            
            let controller = self.storyboard!.instantiateViewController(withIdentifier: "LabelPageViewController") as! LabelPageViewController
            controller.pageText = "Go to Caregiver Portal to add pages to your memory book! You can add text, videos, and photos to create a custom memory book that tells the story of your life."
            controller.pageTitle = "Create your memory book now!"
            finishSetup(controller: controller)
        }
    }
    
    /**
        Helper function that updates the inner view with the correct memory book page and formats it correctly

     */
    func updateView() {
        
        toggleAllPrevious(isHidden: false)
        toggleAllNext(isHidden: false)
        
        if(pageNum == 0) {
            toggleAllPrevious(isHidden: true)
        } else if (pageNum > 0 && (pageNum + 1 != pages.count)) {
            toggleAllPrevious(isHidden: false)
            toggleAllNext(isHidden: false)
        } else {
            toggleAllNext(isHidden: true)
        }
        
        let pageType = pages[pageNum].value(forKeyPath: "templateType") as? String
        
        if(pageType?.hasPrefix("11"))! {
            
            let controller = self.storyboard!.instantiateViewController(withIdentifier: "LabelPhotoPageViewController") as! LabelPhotoPageViewController
            controller.templateType = pageType!
            controller.pageText = pages[pageNum].value(forKeyPath: "text") as! String
            controller.pageTitle = pages[pageNum].value(forKeyPath: "title") as! String
            if (pageType?.hasSuffix("P"))! {
                controller.imageData = pages[pageNum].value(forKeyPath: "image") as? NSData
            } else {
                controller.videoID = pages[pageNum].value(forKeyPath: "videoID") as! String
            }
            finishSetup(controller: controller)
            
        } else if (pageType?.hasSuffix("T"))! {
            
            let controller = self.storyboard!.instantiateViewController(withIdentifier: "LabelPageViewController") as! LabelPageViewController
            controller.pageText = pages[pageNum].value(forKeyPath: "text") as! String
            controller.pageTitle = pages[pageNum].value(forKeyPath: "title") as! String
            finishSetup(controller: controller)
            
        } else {
            
            let controller = self.storyboard!.instantiateViewController(withIdentifier: "PhotoPageViewController") as! PhotoPageViewController
            controller.templateType = pageType!
            controller.pageTitle = pages[pageNum].value(forKeyPath: "title") as! String
            if (pageType?.hasSuffix("P"))! {
                controller.imageData = pages[pageNum].value(forKeyPath: "image") as? NSData
            } else {
                controller.videoID = pages[pageNum].value(forKeyPath: "videoID") as! String
            }
            
            finishSetup(controller: controller)
        }
    }
    
    /**
        Helper function to toggle previous items to given state
        
        - Parameter isHidden: value to toggle to
     */
    func toggleAllPrevious(isHidden: Bool) {
        self.previousButton.isHidden = isHidden
        self.prevIcon.isHidden = isHidden
        self.prevLabel.isHidden = isHidden
    }
    
    /**
        Helper function to toggle next items to given state
     
        - Parameter isHidden: value to toggle to
     */
    func toggleAllNext(isHidden: Bool) {
        self.nextButton.isHidden = isHidden
        self.nextIcon.isHidden = isHidden
        self.nextLabel.isHidden = isHidden
    }
    
    /**
        Helper function to finish step needed for all pages
     
        - Parameter controller: controller to work with
     */
    func finishSetup(controller: UIViewController) {
        
        controller.view.frame = self.containerView.bounds;
        controller.willMove(toParentViewController: self)
        self.containerView.addSubview(controller.view)
        self.addChildViewController(controller)
        controller.didMove(toParentViewController: self)
    }
    
    @IBAction func clickPrevious(_ sender: Any) {
        pageNum = pageNum - 1
        updateView()
    }
    
    @IBAction func clickNext(_ sender: Any) {
        pageNum = pageNum + 1
        updateView()
    }
}
