//
//  String+ConstraintTest.swift
//  OLCoreExtensionTests
//
//  Created by Sofyan Fradenza Adi on 19/12/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest

class StringConstraintExtensionTest: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    func testEstimatedHeight() {
        XCTAssertEqual("ocbc nisp tower jl. prof. dr. satrio".estimatedHeight(
            width: 50,
            font: UIFont.systemFont(ofSize: 16)
        ), 115.0)
        XCTAssertEqual("ocbc".estimatedHeight(
            width: 50,
            font: UIFont.systemFont(ofSize: 16)
        ), 20.0)
    }

    func testWidth() {
        XCTAssertEqual("ocbc nisp tower jl. prof. dr. satrio".estimatedWidth(
            height: 20,
            font: UIFont.systemFont(ofSize: 16)
        ), 237.0)
        XCTAssertEqual("ocbc".estimatedWidth(
            height: 20,
            font: UIFont.systemFont(ofSize: 16)
        ), 36.0)
    }
}
