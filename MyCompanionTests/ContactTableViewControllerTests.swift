//
//  ContactTableViewControllerTests.swift
//  MyCompanion
//
//  Created by Julia Pohlmann on 4/3/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import Foundation
import XCTest
import CoreData
import FontAwesome_swift
@testable import MyCompanion


class ContactTableViewControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testNumberOfSections() {
        class ContactTableViewControllerMock: ContactTableViewController {}
        let controller = ContactTableViewControllerMock()
        let expected = 1
        XCTAssertEqual(expected, controller.numberOfSections(in: UITableView()))
    }
    
    func testTableViewIntReturned() {
        class ContactTableViewControllerMock: ContactTableViewController {}
        let controller = ContactTableViewControllerMock()
        var expected = 0
        XCTAssertEqual(expected, controller.tableView(UITableView(), numberOfRowsInSection: 0))
        controller.contacts = [NSManagedObject(), NSManagedObject()]
        expected = 2
        XCTAssertEqual(expected, controller.tableView(UITableView(), numberOfRowsInSection: 0))
    }
    
    func testSetImage() {
        class ContactTableViewControllerMock: ContactTableViewController {}
        let controller = ContactTableViewControllerMock()
        var cell : ContactTableViewCell = ContactTableViewCell()
        cell.contactImage = UIImageView()
        var contact = createContact()
        
        cell = controller.setImage(cell: cell, contact: contact)
        var actual : NSData = (UIImageJPEGRepresentation(cell.contactImage.image!, 1) as NSData?)!
        
        var expected : NSData = (UIImageJPEGRepresentation(UIImage.fontAwesomeIcon(name: .user, textColor: UIColor.black, size: CGSize(width: 128, height: 128)), 1) as NSData?)!
        
        XCTAssertEqual(expected, actual)
        
        contact = setContactImage(contact: contact)
        cell = controller.setImage(cell: cell, contact: contact)
        actual = (UIImageJPEGRepresentation(cell.contactImage.image!, 1) as NSData?)!
        
        expected = (UIImageJPEGRepresentation(UIImage.fontAwesomeIcon(name: .user, textColor: UIColor.black, size: CGSize(width: 128, height: 128)), 1) as NSData?)!
        
        XCTAssertNotEqual(expected,actual)
        
        deleteContact(contact: contact)
    }
    
//    func testFormatNumber() {
//        class ContactTableViewControllerMock: ContactTableViewController {}
//        let controller = ContactTableViewControllerMock()
//        let cell : ContactTableViewCell = ContactTableViewCell()
//        cell.number = UILabel(frame: CGRect.zero)
//        cell.number.text = "123-456-7890"
//        let purpleColor = UIColor(red: 156/225, green: 39/255, blue: 176/255, alpha: 1.0)
//        let startingCanCallValue = UserDefaults.standard.object(forKey: "canCall") as! Bool
//        
//        UserDefaults.standard.set(false, forKey: "canCall")
//        controller.formatNumber(cell: cell)
//        XCTAssertNotEqual(purpleColor, cell.number.textColor!)
//        
//        UserDefaults.standard.set(true, forKey: "canCall")
//        controller.formatNumber(cell: cell)
//        XCTAssertEqual(purpleColor, cell.number.textColor!)
//        
//        UserDefaults.standard.set(startingCanCallValue, forKey: "canCall")
//    }
    
//    func testFormatEmail() {
//        class ContactTableViewControllerMock: ContactTableViewController {}
//        let controller = ContactTableViewControllerMock()
//        let cell : ContactTableViewCell = ContactTableViewCell()
//        cell.email = UILabel(frame: CGRect.zero)
//        cell.email.text = "abc@123.com"
//        let purpleColor = UIColor(red: 156/225, green: 39/255, blue: 176/255, alpha: 1.0)
//        let startingCanEmailValue = UserDefaults.standard.object(forKey: "canEmail") as! Bool
//        
//        UserDefaults.standard.set(false, forKey: "canEmail")
//        controller.formatEmail(cell: cell)
//        XCTAssertNotEqual(purpleColor, cell.email.textColor!)
//        
//        UserDefaults.standard.set(true, forKey: "canEmail")
//        controller.formatEmail(cell: cell)
//        XCTAssertEqual(purpleColor, cell.email.textColor!)
//        
//        UserDefaults.standard.set(startingCanEmailValue, forKey: "canEmail")
//    }
    
    
    func createContact() -> NSManagedObject{
        let imageData : NSData! = nil
        _ = ContactDataManager.storeContact(name: "TestContact", relationship: "TestRelationship", number: "", email: "", imageData: imageData)
        
        let contacts = ContactDataManager.fetchContacts()
        return contacts.last!
    }
    
    func setContactImage(contact: NSManagedObject) -> NSManagedObject {
        let imageData = UIImageJPEGRepresentation(UIImage.fontAwesomeIcon(name: .camera, textColor: UIColor.black, size: CGSize(width: 128, height: 128)), 1) as NSData?
        _ = ContactDataManager.updateContact(contact: contact, name: "abc", relationship: "123", number: "", email: "", imageData: imageData)
        
        let contacts = ContactDataManager.fetchContacts()
        return contacts.last!
    }
    
    func deleteContact(contact: NSManagedObject) {
        _ = ContactDataManager.deleteContact(contact: contact)
    }
    
}
