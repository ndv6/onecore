//
//  Options+ExtensionTest.swift
//  OLCoreExtensionTests
//
//  Created by Sofyan Fradenza Adi on 19/12/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import ONECore

class OptionsExtensionTest: XCTestCase {
    var options: [Option]!

    override func setUp() {
        super.setUp()
        options = [
            Option(id: "1", text: "a"),
            Option(id: "2", text: "b"),
            Option(id: "3", text: "c"),
            Option(id: "4", text: "d")
        ]
    }

    func testRemove() {
        options.remove(options[0])
        XCTAssertEqual(options[0].id, "2")
        XCTAssertEqual(options[1].id, "3")
        XCTAssertEqual(options[2].id, "4")
    }

    func testContains() {
        XCTAssertEqual(options.contains(Option(id: "1", text: "")), true)
        XCTAssertEqual(options.contains(Option(id: "5", text: "a")), false)
    }

    func testDisplayText() {
        XCTAssertEqual(options.displayText(separator: ","), "a,b,c,d")
        XCTAssertEqual([Option]().displayText(separator: ","), "")
    }
}
