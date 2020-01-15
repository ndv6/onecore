//
//  StringValidationTest.swift
//  OLCoreExtensionTests
//
//  Created by Steven Tiolie on 03/12/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import ONECore

class StringValidationTest: XCTestCase {

    override func setUp() {}
    override func tearDown() {}

    func testIsValidURL() {
        let inputText = "https://google.com"
        XCTAssertTrue(inputText.isValidURL(), "Wrong URL Format!")
    }

    func testIsNotValidURL() {
        let inputText = " "
        XCTAssertFalse(inputText.isValidURL(), "Correct URL Format")
    }

    func testIsBackspace() {
        let inputText = ""
        XCTAssertTrue(inputText.isBackspace(), "Text is not backspace!")
    }

    func testIsValidRegexEmail() {
        let inputText = "aldo@gmail.com"
        let rule = RegexString.email
        XCTAssertTrue(inputText.isValid(regexRule: rule), "Text is not Email!")
    }
}
