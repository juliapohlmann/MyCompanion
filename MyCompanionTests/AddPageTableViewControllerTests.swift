//
//  AddPageTableViewControllerTests.swift
//  MyCompanion
//
//  Created by Julia Pohlmann on 4/24/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import XCTest
@testable import MyCompanion

class AddPageTableViewControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNumberOfSections() {
        class AddPageTableViewControllerMock: AddPageTableViewController {}
        let controller = AddPageTableViewControllerMock()
        let expected = 5
        XCTAssertEqual(expected, controller.numberOfSections(in: UITableView()))
    }
    
    func testTableViewIntReturned() {
        class AddPageTableViewControllerMock: AddPageTableViewController {}
        let controller = AddPageTableViewControllerMock()
        var expected = 4
        XCTAssertEqual(expected, controller.tableView(UITableView(), numberOfRowsInSection: 0))
        XCTAssertEqual(expected, controller.tableView(UITableView(), numberOfRowsInSection: 1))
        expected = 1
        XCTAssertEqual(expected, controller.tableView(UITableView(), numberOfRowsInSection: 2))
    }
    
    func testTableViewStringReturned() {
        class AddPageTableViewControllerMock: AddPageTableViewController {}
        let controller = AddPageTableViewControllerMock()
        var expected = "1 Picture/Text"
        XCTAssertEqual(expected, controller.tableView(UITableView(), titleForHeaderInSection: 0)!)
        expected = "1 Video/Text"
        XCTAssertEqual(expected, controller.tableView(UITableView(), titleForHeaderInSection: 1)!)
        expected = "1 Text"
        XCTAssertEqual(expected, controller.tableView(UITableView(), titleForHeaderInSection: 2)!)
        expected = "1 Picture"
        XCTAssertEqual(expected, controller.tableView(UITableView(), titleForHeaderInSection: 3)!)
        expected = "1 Video"
        XCTAssertEqual(expected, controller.tableView(UITableView(), titleForHeaderInSection: 4)!)
        expected = "Error"
        XCTAssertEqual(expected, controller.tableView(UITableView(), titleForHeaderInSection: 5)!)
    }
    
    func testConvertIndexPathToRow() {
        class AddPageTableViewControllerMock: AddPageTableViewController {}
        let controller = AddPageTableViewControllerMock()
        
        var expected = 0
        var indexPath = NSIndexPath(row: 0, section: 0)
        XCTAssertEqual(expected, controller.convertIndexPathToRow(indexPath: indexPath as IndexPath))
        
        expected = 4
        indexPath = NSIndexPath(row: 0, section: 1)
        XCTAssertEqual(expected, controller.convertIndexPathToRow(indexPath: indexPath as IndexPath))
        
        expected = 8
        indexPath = NSIndexPath(row: 0, section: 2)
        XCTAssertEqual(expected, controller.convertIndexPathToRow(indexPath: indexPath as IndexPath))
    }
    
}
