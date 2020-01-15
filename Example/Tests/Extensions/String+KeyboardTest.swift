//
//  StringKeyboardTest.swift
//  OLCoreExtensionTests
//
//  Created by Steven Tiolie on 03/12/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest

class StringKeyboardTest: XCTestCase {

    override func setUp() {}
    override func tearDown() {}

    func testCopyToKeyboard() {
        let inputText = "copiedText"
        let expectedResult = inputText
        inputText.copyToKeyboard()
        XCTAssertEqual(inputText.pasteFromKeyboard(), expectedResult)
    }
}
