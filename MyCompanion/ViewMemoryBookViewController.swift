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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pages = fetchPages()
        
        if(pages.count != 0) {
            updateView()
        } else {
            
            self.previousButton.isHidden = true
            self.nextButton.isHidden = true
            
        }
        
    }
    
    func updateView() {
        
        self.previousButton.isHidden = false
        self.nextButton.isHidden = false
        
        //self.willMove(toParentViewController: nil)
        //self.collectionView.removeFromSuperview()
        //self.removeFromParentViewController()
        
        if(pageNum == 0) {
            
            self.previousButton.isHidden = true
            
        }
        if(pageNum + 1 == pages.count) {
            
            self.nextButton.isHidden = true
            
        }
        
        let pageType = pages[pageNum].value(forKeyPath: "templateType") as? String
        if(pageType?.hasPrefix("11"))! {
            
            let controller = self.storyboard!.instantiateViewController(withIdentifier: "LabelPhotoPageViewController") as! LabelPhotoPageViewController
            controller.templateType = pageType!
            controller.pageText = pages[pageNum].value(forKeyPath: "text") as! String
            controller.pageTitle = pages[pageNum].value(forKeyPath: "title") as! String
            if (pageType?.hasSuffix("P"))! {
                controller.imageData = pages[pageNum].value(forKeyPath: "image") as! NSData
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
                controller.imageData = pages[pageNum].value(forKeyPath: "image") as! NSData
            } else {
                controller.videoID = pages[pageNum].value(forKeyPath: "videoID") as! String
            }
            
            
            finishSetup(controller: controller)
        }
        
        
        
    }
    
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
    
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func fetchPages() -> [NSManagedObject] {
        var pages : [NSManagedObject] = []
        let context = getContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MemoryBook")
        
        do {
            pages = try context.fetch(fetchRequest)
            return pages
        } catch _ as NSError {
            return []
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
