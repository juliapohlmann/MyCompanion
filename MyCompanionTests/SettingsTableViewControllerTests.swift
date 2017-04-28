//
//  SettingsTableViewControllerTests.swift
//  MyCompanion
//
//  Created by Julia Pohlmann on 4/3/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import Foundation
import XCTest
@testable import MyCompanion

class SettingsTableViewControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTableViewHeaders() {
        class SettingsTableViewControllerMock: SettingsTableViewController {}
        let controller = SettingsTableViewControllerMock()
        var expected = "Contacts Settings"
        XCTAssertEqual(expected, controller.tableView(UITableView(), titleForHeaderInSection: 0))
        expected = "Reminders Settings"
        XCTAssertEqual(expected, controller.tableView(UITableView(), titleForHeaderInSection: 1))
        expected = "Security Settings"
        XCTAssertEqual(expected, controller.tableView(UITableView(), titleForHeaderInSection: 2))
        expected = ""
        XCTAssertEqual(expected, controller.tableView(UITableView(), titleForHeaderInSection: 3))
//        expected = "mistake"
//        XCTAssertEqual(expected, controller.tableView(UITableView(), titleForHeaderInSection: 4))

    }
    
}
