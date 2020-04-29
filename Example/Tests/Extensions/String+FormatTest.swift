//
//  StringFormatTest.swift
//  OLCoreExtensionTests
//
//  Created by Steven Tiolie on 03/12/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import ONECore

class StringFormatTest: XCTestCase {
    func testDoubleValue() {
        XCTAssertEqual("9.8987".doubleValue, Double(9.8987))
        XCTAssertEqual("9,8987".doubleValue, Double(9.8987))
        XCTAssertEqual("9:8987".doubleValue, Double(0.0))
    }

    func testFloatValue() {
        XCTAssertEqual("9.8987".floatValue, Float(9.8987))
        XCTAssertEqual("9,8987".floatValue, Float(9.8987))
        XCTAssertEqual("9:8987".floatValue, Float(0.0))
    }

    func testDigits() {
        XCTAssertEqual("  abc1oi2j3nn--==  ^%$#456\"7   ".digits, "1234567")
    }

    func testWithThousandSeparator() {
        XCTAssertEqual("abcdefg".withThousandSeparator(), "")
        XCTAssertEqual("0".withThousandSeparator(), "0")
        XCTAssertEqual("1".withThousandSeparator(), "1")
        XCTAssertEqual("10".withThousandSeparator(), "10")
        XCTAssertEqual("100".withThousandSeparator(), "100")
        XCTAssertEqual("1000".withThousandSeparator(), "1.000")
        XCTAssertEqual("10000".withThousandSeparator(), "10.000")
        XCTAssertEqual("0010000".withThousandSeparator(), "10.000")
        XCTAssertEqual("10000000".withThousandSeparator(), "10.000.000")
    }

    func testFormatInIndonesianMobilePhone() {
        XCTAssertEqual("085250600000".formatInIndonesianMobilePhone(), "085250600000")
        XCTAssertEqual("+6285250600000".formatInIndonesianMobilePhone(), "085250600000")
        XCTAssertEqual("6285250600000".formatInIndonesianMobilePhone(), "085250600000")
        XCTAssertEqual("+1185250600000".formatInIndonesianMobilePhone(), "+1185250600000")
    }

    func testToAccessibilityFormat() {
        XCTAssertEqual("  LaBEL-cu  rrent_pr 1ce".toAccessibilityFormat(), "__label-cu__rrent_pr_1ce")
    }

    func testRemoveAllWhitespaces() {
        XCTAssertEqual("  a  bc\n\t\rd \ne\nf\ng\th\ri".removeAllWhitespaces(), "abcdefghi")
    }

    func testRemovePrefix() {
        XCTAssertEqual("Rp1.200.000".removePrefix("Rp"), "1.200.000")
        XCTAssertEqual("1.200.000".removePrefix("Rp"), "1.200.000")
        XCTAssertEqual("Rp1.200.000".removePrefix(""), "Rp1.200.000")
        XCTAssertEqual("$1.200.000".removePrefix("$"), "1.200.000")
    }

    func  testGetSuffix() {
        XCTAssertEqual("081110000121".getSuffix(5), "00121")
        XCTAssertEqual("12".getSuffix(5), "12")
    }

    func testGetPrefix() {
        XCTAssertEqual("081110000121".getPrefix(5), "08111")
        XCTAssertEqual("12".getPrefix(5), "12")
    }

    func testGetFirstWord() {
        let inputText = "satu dua tiga empat lima enam tujuh delapan"
        let expectedResult = "satu"
        XCTAssertEqual(inputText.getFirstWord(), expectedResult, "Wrong First Word!")
    }

    func testAppend() {
        var text = "ol"
        text.append(text: "")
        XCTAssertEqual(text, "ol")
        text = "ol"
        text.append(text: "core")
        XCTAssertEqual(text, "olcore")
        text = "ol"
        text.append(text: "core", separator: "-")
        XCTAssertEqual(text, "ol-core")
    }

    func testRemoveMultipleWhitespaces() {
        XCTAssertEqual("   satu dua   tiga empat  ".removeMultipleWhitespaces, "satu dua tiga empat")
    }

    func testFilterAllowedCharacters() {
        XCTAssertEqual("=-\"$-a08kbc91p{2lk 3".filterAllowedCharacters("$abc123"), "$abc123")
    }

    func testAppendLeading() {
        XCTAssertEqual("123".appendLeading(withCharacter: "0", targetLength: 5), "00123")
        XCTAssertEqual("12345".appendLeading(withCharacter: "0", targetLength: 5), "12345")
        XCTAssertEqual("123456".appendLeading(withCharacter: "0", targetLength: 5), "123456")
        XCTAssertEqual("".appendLeading(withCharacter: "0", targetLength: 5), "00000")
        XCTAssertEqual("123".appendLeading(withCharacter: "0", targetLength: 0), "123")
        XCTAssertEqual("123".appendLeading(withCharacter: "0", targetLength: -5), "123")
    }
}
