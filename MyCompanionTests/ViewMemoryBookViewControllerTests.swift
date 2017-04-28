//
//  ViewMemoryBookViewControllerTests.swift
//  MyCompanion
//
//  Created by Julia Pohlmann on 4/28/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import Foundation
import XCTest
import UIKit
@testable import MyCompanion

class ViewMemoryBookViewControllerTests: XCTestCase {
    
    func testToggleAllPrevious() {
        class ViewMemoryBookViewControllerMock: ViewMemoryBookViewController {}
        let controller = ViewMemoryBookViewControllerMock()
        controller.previousButton = UIButton()
        controller.prevIcon = UIImageView()
        controller.prevLabel = UILabel()
        
        controller.toggleAllPrevious(isHidden: true)
        XCTAssertTrue(controller.previousButton.isHidden)
        XCTAssertTrue(controller.prevIcon.isHidden)
        XCTAssertTrue(controller.prevIcon.isHidden)
        
        controller.toggleAllPrevious(isHidden: false)
        XCTAssertFalse(controller.previousButton.isHidden)
        XCTAssertFalse(controller.prevIcon.isHidden)
        XCTAssertFalse(controller.prevIcon.isHidden)
    }
    
    func testToggleAllNext() {
        class ViewMemoryBookViewControllerMock: ViewMemoryBookViewController {}
        let controller = ViewMemoryBookViewControllerMock()
        controller.nextButton = UIButton()
        controller.nextIcon = UIImageView()
        controller.nextLabel = UILabel()
        
        controller.toggleAllNext(isHidden: true)
        XCTAssertTrue(controller.nextButton.isHidden)
        XCTAssertTrue(controller.nextIcon.isHidden)
        XCTAssertTrue(controller.nextLabel.isHidden)
        
        controller.toggleAllNext(isHidden: false)
        XCTAssertFalse(controller.nextButton.isHidden)
        XCTAssertFalse(controller.nextIcon.isHidden)
        XCTAssertFalse(controller.nextLabel.isHidden)
    }

}
