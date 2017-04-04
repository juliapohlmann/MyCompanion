//
//  EditRemindersTableViewControllerTests.swift
//  MyCompanion
//
//  Created by Julia Pohlmann on 4/3/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import Foundation
import XCTest
import CoreData
@testable import MyCompanion


class EditRemindersTableViewControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNumberOfSections() {
        class EditRemindersTableViewControllerMock: EditRemindersTableViewController {}
        let controller = EditRemindersTableViewControllerMock()
        let expected = 1
        XCTAssertEqual(expected, controller.numberOfSections(in: UITableView()))
    }
    
    func testTableViewIntReturned() {
        class EditRemindersTableViewControllerMock: EditRemindersTableViewController {}
        let controller = EditRemindersTableViewControllerMock()
        var expected = 0
        XCTAssertEqual(expected, controller.tableView(UITableView(), numberOfRowsInSection: 0))
        controller.reminders = [NSManagedObject(), NSManagedObject()]
        expected = 2
        XCTAssertEqual(expected, controller.tableView(UITableView(), numberOfRowsInSection: 0))
    }
}
