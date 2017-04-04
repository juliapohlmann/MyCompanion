//
//  ReminderDetailViewController.swift
//  MyCompanion
//
//  Created by Julia Pohlmann on 4/3/17.
//  Copyright © 2017 EECS395. All rights reserved.
//
import XCTest
import Foundation
import CoreData
import TextFieldEffects
@testable import MyCompanion


class ReminderDetailViewControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCheckInputValidity() {
        class ReminderDetailViewControllerMock: ReminderDetailViewController {
            var alertTitle : String = ""
            var alertMessage : String = ""
            
            override func sendAlert(title: String, message: String) {
                alertTitle = title
                alertMessage = message
            }
        }
        let controller = ReminderDetailViewControllerMock()
        controller.nameTextField = JiroTextField()
        controller.nameTextField.text = ""
        
        XCTAssertFalse(controller.checkInputValidity())
        
        controller.nameTextField.text = "a"
        XCTAssertTrue(controller.checkInputValidity())
    }
    
}
