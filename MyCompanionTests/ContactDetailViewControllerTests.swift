//
//  ContactDetailViewControllerTests.swift
//  MyCompanion
//
//  Created by Julia Pohlmann on 4/3/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import Foundation
import XCTest
import TextFieldEffects

@testable import MyCompanion


class ContactDetailViewControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCheckInputValidity() {
        class ContactDetailViewControllerMock: ContactDetailViewController {
            var alertTitle : String = ""
            var alertMessage : String = ""
            
            override func sendAlert(title: String, message: String) {
                alertTitle = title
                alertMessage = message
            }
        }
        let controller = ContactDetailViewControllerMock()
        
        controller.nameTextField = JiroTextField()
        controller.relationshipTextField = JiroTextField()
        controller.numberTextField = JiroTextField()
        controller.emailTextField = JiroTextField()
        
        controller.nameTextField.text = "abc"
        controller.relationshipTextField.text = "def"
        controller.numberTextField.text = "123-456-7890"
        controller.emailTextField.text = "abc@123.com"
        
        //all valid
        XCTAssertTrue(controller.checkInputValidity())
        XCTAssertEqual("", controller.alertTitle)
        XCTAssertEqual("", controller.alertMessage)

        //name missing
        controller.nameTextField.text = ""
        XCTAssertFalse(controller.checkInputValidity())
        XCTAssertEqual("Missing Name", controller.alertTitle)
        XCTAssertEqual("Please enter a name for the contact", controller.alertMessage)
        controller.nameTextField.text = "abc"
        
        //relationship missing
        controller.relationshipTextField.text = ""
        XCTAssertFalse(controller.checkInputValidity())
        XCTAssertEqual("Missing Relationship", controller.alertTitle)
        XCTAssertEqual("Please enter a relationship for the contact", controller.alertMessage)
        controller.relationshipTextField.text = "def"
        
        //number missing
        controller.numberTextField.text = ""
        controller.alertMessage = ""
        controller.alertTitle = ""
        XCTAssertTrue(controller.checkInputValidity())
        XCTAssertEqual("", controller.alertTitle)
        XCTAssertEqual("", controller.alertMessage)
        
        //number formatted wrong
        class ContactDetailViewControllerMock1: ContactDetailViewController {
            var alertTitle : String = ""
            var alertMessage : String = ""
            
            override func sendAlert(title: String, message: String) {
                alertTitle = title
                alertMessage = message
            }
            
            override func isValidNumber(value: String) -> Bool {
                return false
            }
        }
        let controller1 = ContactDetailViewControllerMock1()
        controller1.nameTextField = JiroTextField()
        controller1.relationshipTextField = JiroTextField()
        controller1.numberTextField = JiroTextField()
        controller1.emailTextField = JiroTextField()
        
        controller1.nameTextField.text = "abc"
        controller1.relationshipTextField.text = "def"
        controller1.numberTextField.text = "123-456-7890"
        controller1.emailTextField.text = "abc@123.com"
        
        controller1.alertMessage = ""
        controller1.alertTitle = ""
        XCTAssertFalse(controller1.checkInputValidity())
        XCTAssertEqual("Incorrect Phone Number", controller1.alertTitle)
        XCTAssertEqual("Please enter a valid phone number (ie. 555-123-4567)", controller1.alertMessage)
        controller1.numberTextField.text = "123-456-7890"
        
        //email missing
        controller.emailTextField.text = ""
        controller.alertMessage = ""
        controller.alertTitle = ""
        XCTAssertTrue(controller.checkInputValidity())
        XCTAssertEqual("", controller.alertTitle)
        XCTAssertEqual("", controller.alertMessage)
        
        //email formatted wrong
        class ContactDetailViewControllerMock2: ContactDetailViewController {
            var alertTitle : String = ""
            var alertMessage : String = ""
            
            override func sendAlert(title: String, message: String) {
                alertTitle = title
                alertMessage = message
            }
            
            override func isValidEmail(value: String) -> Bool {
                return false
            }
        }
        
        let controller2 = ContactDetailViewControllerMock2()
        controller2.nameTextField = JiroTextField()
        controller2.relationshipTextField = JiroTextField()
        controller2.numberTextField = JiroTextField()
        controller2.emailTextField = JiroTextField()
        
        controller2.nameTextField.text = "abc"
        controller2.relationshipTextField.text = "def"
        controller2.numberTextField.text = "123-456-7890"
        controller2.emailTextField.text = "abc@123.com"
        
        controller2.emailTextField.text = "abc"
        controller2.alertMessage = ""
        controller2.alertTitle = ""
        XCTAssertFalse(controller2.checkInputValidity())
        XCTAssertEqual("Incorrect Email Address", controller2.alertTitle)
        XCTAssertEqual("Please enter a valid email address", controller2.alertMessage)
    }
    
    func testIsValidNumber() {
        class ContactDetailViewControllerMock: ContactDetailViewController {}
        let controller = ContactDetailViewControllerMock()
        
        XCTAssertTrue(controller.isValidNumber(value: "123-456-1910"))
        XCTAssertFalse(controller.isValidNumber(value: "12-345-1203"))
        XCTAssertFalse(controller.isValidNumber(value: "123-45-1203"))
        XCTAssertFalse(controller.isValidNumber(value: "123-456-123"))
        XCTAssertFalse(controller.isValidNumber(value: "123-454-12031"))
        XCTAssertFalse(controller.isValidNumber(value: "1234-452-1203"))
        XCTAssertFalse(controller.isValidNumber(value: "123-4533-1203"))
        XCTAssertFalse(controller.isValidNumber(value: "aaa-bbb-cccc"))
        XCTAssertFalse(controller.isValidNumber(value: "123"))
        XCTAssertFalse(controller.isValidNumber(value: "123-456"))
        XCTAssertFalse(controller.isValidNumber(value: "123-456-7890-123"))
    }
    
}
