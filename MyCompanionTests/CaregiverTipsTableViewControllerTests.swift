//
//  CaregiverTipsTableViewControllerTests.swift
//  MyCompanion
//
//  Created by Julia Pohlmann on 4/28/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import Foundation
import XCTest
@testable import MyCompanion

class CaregiverTipsTableViewControllerTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNumberOfSections() {
        class CaregiverTipsTableViewControllerMock: CaregiverTipsTableViewController {}
        let controller = CaregiverTipsTableViewControllerMock()
        let expected = 5
        XCTAssertEqual(expected, controller.numberOfSections(in: UITableView()))
    }
    
    func testConvertIndexPathToRow() {
        class CaregiverTipsTableViewControllerMock: CaregiverTipsTableViewController {}
        let controller = CaregiverTipsTableViewControllerMock()
        var indexPath = NSIndexPath(row: 2, section: 0)
        var expected = 2
        XCTAssertEqual(expected, controller.convertIndexPathToRow(indexPath: indexPath as IndexPath))
        
        indexPath = NSIndexPath(row: 3, section: 1)
        expected = 7
        XCTAssertEqual(expected, controller.convertIndexPathToRow(indexPath: indexPath as IndexPath))

        indexPath = NSIndexPath(row: 2, section: 2)
        expected = 11
        XCTAssertEqual(expected, controller.convertIndexPathToRow(indexPath: indexPath as IndexPath))
        
        indexPath = NSIndexPath(row: 1, section: 3)
        expected = 23
        XCTAssertEqual(expected, controller.convertIndexPathToRow(indexPath: indexPath as IndexPath))
        
        indexPath = NSIndexPath(row: 3, section: 4)
        expected = 28
        XCTAssertEqual(expected, controller.convertIndexPathToRow(indexPath: indexPath as IndexPath))
    }

}
