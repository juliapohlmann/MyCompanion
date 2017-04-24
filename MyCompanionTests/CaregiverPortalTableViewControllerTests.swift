//
//  CaregiverPortalTableViewControllerTests.swift
//  MyCompanion
//
//  Created by Julia Pohlmann on 4/3/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import Foundation
import XCTest
@testable import MyCompanion

class CaregiverPortalTableViewControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNumberOfSections() {
        class CaregiverPortalTableViewControllerMock: CaregiverPortalTableViewController {}
        let controller = CaregiverPortalTableViewControllerMock()
        let expected = 1
        XCTAssertEqual(expected, controller.numberOfSections(in: UITableView()))
    }
    
    func testTableViewIntReturned() {
        class CaregiverPortalTableViewControllerMock: CaregiverPortalTableViewController {}
        let controller = CaregiverPortalTableViewControllerMock()
        let expected = 5
        XCTAssertEqual(expected, controller.tableView(UITableView(), numberOfRowsInSection: 0))
    }
    
    func testTableViewDidSelectRow() {
        class CaregiverPortalTableViewControllerMock: CaregiverPortalTableViewController {
            var segueToPerform = ""
            override func performSegue(withIdentifier identifier: String, sender: Any?) {
                self.segueToPerform = identifier
            }
        }
        let controller = CaregiverPortalTableViewControllerMock()
        
        var expected = "generalSettings"
        var indexPath = NSIndexPath(row: 0, section: 0)
        controller.tableView(UITableView(), didSelectRowAt: indexPath as IndexPath)
        XCTAssertEqual(expected, controller.segueToPerform)
        
        expected = "editMemoryBook"
        indexPath = NSIndexPath(row: 1, section: 0)
        controller.tableView(UITableView(), didSelectRowAt: indexPath as IndexPath)
        XCTAssertEqual(expected, controller.segueToPerform)
        
        expected = "editContact"
        indexPath = NSIndexPath(row: 2, section: 0)
        controller.tableView(UITableView(), didSelectRowAt: indexPath as IndexPath)
        XCTAssertEqual(expected, controller.segueToPerform)
        
        expected = "editReminders"
        indexPath = NSIndexPath(row: 3, section: 0)
        controller.tableView(UITableView(), didSelectRowAt: indexPath as IndexPath)
        XCTAssertEqual(expected, controller.segueToPerform)
        
        expected = "caregiverTips"
        indexPath = NSIndexPath(row: 4, section: 0)
        controller.tableView(UITableView(), didSelectRowAt: indexPath as IndexPath)
        XCTAssertEqual(expected, controller.segueToPerform)
    }
}
