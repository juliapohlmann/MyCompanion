//
//  LabelPhotoPageViewControllerTests.swift
//  MyCompanion
//
//  Created by Julia Pohlmann on 4/28/17.
//  Copyright © 2017 EECS395. All rights reserved.
//

import Foundation
import XCTest
import UIKit
@testable import MyCompanion

class LabelPhotoPageViewControllerTests: XCTestCase {
    
    func testFormatImageLocation() {
        class LabelPhotoPageViewControllerMock: LabelPhotoPageViewController {}
        let controller = LabelPhotoPageViewControllerMock()
        
        let imageView = UIImageView()
        var label : UILabel
        var expectedLabelFrame = CGRect(x: 20, y: 362, width: 742, height: 268)
        var expectedImageFrame = CGRect(x: 266, y: 104, width: 250, height: 250)
        
        controller.templateType = "11TP"
        label = controller.formatImageLocation(imageView: imageView)
        XCTAssertEqual(expectedLabelFrame, label.frame)
        XCTAssertEqual(expectedImageFrame, imageView.frame)
        
        controller.templateType = "11DP"
        expectedLabelFrame = CGRect(x: 20, y: 104, width: 742, height: 268)
        expectedImageFrame = CGRect(x: 266, y: 380, width: 250, height: 250)
        label = controller.formatImageLocation(imageView: imageView)
        XCTAssertEqual(expectedLabelFrame, label.frame)
        XCTAssertEqual(expectedImageFrame, imageView.frame)
        
        controller.templateType = "11RP"
        expectedLabelFrame = CGRect(x: 20, y: 104, width: 484, height: 526)
        expectedImageFrame = CGRect(x: 512, y: 200, width: 250, height: 250)
        label = controller.formatImageLocation(imageView: imageView)
        XCTAssertEqual(expectedLabelFrame, label.frame)
        XCTAssertEqual(expectedImageFrame, imageView.frame)
        
        controller.templateType = "11LP"
        expectedLabelFrame = CGRect(x: 278, y: 104, width: 484, height: 526)
        expectedImageFrame = CGRect(x: 20, y: 200, width: 250, height: 250)
        label = controller.formatImageLocation(imageView: imageView)
        XCTAssertEqual(expectedLabelFrame, label.frame)
        XCTAssertEqual(expectedImageFrame, imageView.frame)
    }
    
    func testFormatLabel() {
        class LabelPhotoPageViewControllerMock: LabelPhotoPageViewController {}
        let controller = LabelPhotoPageViewControllerMock()
        controller.pageText = "abc def ghi jkl"
        let label : UILabel = UILabel()
        
        controller.formatLabel(label: label)
        XCTAssertEqual(.left, label.textAlignment)
        XCTAssertEqual(UIFont(name: "AvenirNext-DemiBold", size: 30), label.font)
        XCTAssertEqual("abc def ghi jkl", label.text)
        XCTAssertEqual(100, label.numberOfLines)
    }
}
