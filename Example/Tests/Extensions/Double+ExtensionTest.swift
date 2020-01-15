//
//  DoubleExtensionTest.swift
//  OLCoreExtensionTests
//
//  Created by Steven Tiolie on 19/11/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import ONECore

class DoubleExtensionTest: XCTestCase {
    var doubleValue = DefaultValue.emptyDouble

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testClean() {
        XCTAssertEqual(Double(100.82837102000).clean, "100.828")
        XCTAssertEqual(Double(100.82867102000).clean, "100.829")
        XCTAssertEqual(Double(100.8).clean, "100.8")
        XCTAssertEqual(Double(100).clean, "100")
    }

    func testToCurrencyIDR() {
        XCTAssertEqual(Double(10000000).toCurrencyIDR(), "Rp 10.000.000")
        XCTAssertEqual(Double(-10000000).toCurrencyIDR(), "-Rp 10.000.000")
    }

    func testRounded() {
        XCTAssertEqual(Double(100.8249).rounded(toPlaces: 2), 100.82)
        XCTAssertEqual(Double(100.8259).rounded(toPlaces: 2), 100.83)
        XCTAssertEqual(Double(100.0000).rounded(toPlaces: 2), 100.00)
        XCTAssertEqual(Double(100.8259).rounded(toPlaces: 0), 101)
        XCTAssertEqual(Double(100).rounded(toPlaces: 0), 100)
    }

    func testRemoveZerosFromEnd() {
        XCTAssertEqual(Double(100.00).removeZerosFromEnd(), "100")
        XCTAssertEqual(Double(100).removeZerosFromEnd(), "100")
        XCTAssertEqual(Double(100.50).removeZerosFromEnd(), "100.5")
    }
}
