//
//  ViewController.swift
//  MyCompanion
//
//  Created by Julia Pohlmann on 1/31/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import UIKit


class DashboardViewController: UIViewController {
    
    @IBOutlet var switchingContainer: UIView!
    var currentViewController: UIViewController?
    var controllerIdToSwitchTo: String = "blueComp"
    var otherControllerId: String = "pinkComp"
    
    override func viewDidLoad() {
        self.currentViewController = self.storyboard?.instantiateViewController(withIdentifier: "pinkComp")
        // need to update this code
        // self.currentViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        // self.addChildViewController(self.currentViewController!)
        self.addSubview(subView: self.currentViewController!.view, toView: self.switchingContainer)
        super.viewDidLoad()
        
        startRotation()

    }
    
    func startRotation() {
        var _ = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(DashboardViewController.switchView), userInfo: nil, repeats: true)
    }
    
    func switchView() {
        //print("CALLED SWITCH VIEW")
        let newViewController = self.storyboard?.instantiateViewController(withIdentifier: self.controllerIdToSwitchTo)
        newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        self.cycleFromViewController(oldViewController: self.currentViewController!, toViewController: newViewController!)
        self.currentViewController = newViewController
        let temp = self.controllerIdToSwitchTo
        self.controllerIdToSwitchTo = otherControllerId
        self.otherControllerId = temp
    }
    
    
    func cycleFromViewController(oldViewController: UIViewController, toViewController newViewController: UIViewController) {
        oldViewController.willMove(toParentViewController: nil)
        self.addChildViewController(newViewController)
        self.addSubview(subView: newViewController.view, toView:self.switchingContainer!)
        newViewController.view.alpha = 0
        newViewController.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5, animations: {
            newViewController.view.alpha = 1
            oldViewController.view.alpha = 0
        },
                                   completion: { finished in
                                    oldViewController.view.removeFromSuperview()
                                    oldViewController.removeFromParentViewController()
                                    newViewController.didMove(toParentViewController: self)
        })
    }
    
    func addSubview(subView:UIView, toView parentView:UIView) {
        parentView.addSubview(subView)
        
        var viewBindingsDict = [String: AnyObject]()
        viewBindingsDict["subView"] = subView
        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[subView]|",
                                                                                 options: [], metrics: nil, views: viewBindingsDict))
        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[subView]|",
                                                                            options: [], metrics: nil, views: viewBindingsDict))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

