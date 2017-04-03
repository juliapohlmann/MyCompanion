//
//  EditContactTableViewControllerTests.swift
//  MyCompanion
//
//  Created by Julia Pohlmann on 4/3/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import Foundation
import XCTest
import CoreData
@testable import MyCompanion


class EditContactTableViewControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNumberOfSections() {
        class EditContactTableViewControllerMock: EditContactTableViewController {}
        let controller = EditContactTableViewControllerMock()
        let expected = 1
        XCTAssertEqual(expected, controller.numberOfSections(in: UITableView()))
    }
    
    func testTableViewIntReturned() {
        class EditContactTableViewControllerMock: EditContactTableViewController {}
        let controller = EditContactTableViewControllerMock()
        var expected = 0
        XCTAssertEqual(expected, controller.tableView(UITableView(), numberOfRowsInSection: 0))
        controller.contacts = [NSManagedObject(), NSManagedObject()]
        expected = 2
        XCTAssertEqual(expected, controller.tableView(UITableView(), numberOfRowsInSection: 0))
    }
    
    func testTableViewSelectedRow() {
        class EditContactTableViewControllerMock: EditContactTableViewController {
            var segueToPerform = ""
            override func performSegue(withIdentifier identifier: String, sender: Any?) {
                self.segueToPerform = identifier
            }
        }
        let controller = EditContactTableViewControllerMock()
        let expected = "editContactSegue"
        let indexPath = NSIndexPath(row: 0, section: 0)
        controller.tableView(UITableView(), didSelectRowAt: indexPath as IndexPath)
        XCTAssertEqual(expected, controller.segueToPerform)
    }
    
    
    
}
