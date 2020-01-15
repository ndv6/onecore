//
//  ArrayExtensionTest.swift
//  OLCoreExtensionTests
//
//  Created by Steven Tiolie on 19/11/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest

class ArrayExtensionTest: XCTestCase {
    var list: [Int]!

    override func setUp() {
        super.setUp()
        list = [Int]()
    }

    override func tearDown() {
        list = nil
        super.tearDown()
    }

    func testIsEmpty() {
        list.removeAll()
        XCTAssertTrue(list.isEmpty)
    }

    func testIsNotEmpty() {
        list = [0, 1]
        XCTAssertFalse(list.isEmpty)
    }

    func testChunked() {
        let data = [1, 2, 3, 4]
        let expected = [[1,2],[3,4]]
        XCTAssertEqual(data.chunked(into: 2), expected)
    }
}
