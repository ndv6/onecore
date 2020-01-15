//
//  TimeInterval+FormatTest.swift
//  OLCoreExtensionTests
//
//  Created by ALDO LAZUARDI on 20/12/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest

class TimeIntervalExtensionTest: XCTestCase {

    override func setUp() {}

    override func tearDown() {}

    func testConvertToHumanTextFormat() {
        let interval = 900.0
        let expected = "15:00"
        XCTAssertEqual(interval.convertToHumanTextFormat(), expected)
    }
}
