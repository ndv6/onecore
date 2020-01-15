//
//  Float+ExtensionTest.swift
//  OLCoreExtensionTests
//
//  Created by Sofyan Fradenza Adi on 19/12/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest

class FloatExtensionTest: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testClean() {
        XCTAssertEqual(Float(100.82837102000).clean, "100.82837")
        XCTAssertEqual(Float(100.82867102000).clean, "100.828674")
        XCTAssertEqual(Float(100.8).clean, "100.8")
        XCTAssertEqual(Float(100).clean, "100")
    }

    func testRounded() {
        XCTAssertEqual(Float(100.8249).rounded(toPlaces: 2), 100.82)
        XCTAssertEqual(Float(100.8259).rounded(toPlaces: 2), 100.83)
        XCTAssertEqual(Float(100.0000).rounded(toPlaces: 2), 100.00)
        XCTAssertEqual(Float(100.8259).rounded(toPlaces: 0), 101)
        XCTAssertEqual(Float(100).rounded(toPlaces: 0), 100)
    }
}
