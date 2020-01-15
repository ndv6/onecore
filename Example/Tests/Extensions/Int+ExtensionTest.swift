//
//  IntExtensionTest.swift
//  OLCoreExtensionTests
//
//  Created by Steven Tiolie on 19/11/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import ONECore

class IntExtensionTest: XCTestCase {
    var intValue: Int!

    override func setUp() {
        super.setUp()
        intValue = DefaultValue.emptyInt
    }

    override func tearDown() {
        intValue = nil
        super.tearDown()
    }

    func testPercentOf() {
        intValue = 12
        XCTAssertEqual(intValue.percentOf(120), 10)
    }

    func testConvertToPercentage() {
        intValue = 50
        XCTAssertEqual(intValue.convertToPercentage(), 0.5)
    }

}
