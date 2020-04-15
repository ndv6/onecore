//
//  String+DateTest.swift
//  OLCoreExtensionTests
//
//  Created by Sofyan Fradenza Adi on 19/12/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest

class StringDateTest: XCTestCase {
    let dateFormatter = DateFormatter()

    func testToDate() {
        XCTAssertEqual(
            "2020-12-31T00:00:00+0000".toDate(format: "yyyy-MM-dd'T'HH:mm:ssZ").toUnixTimestamp(),
            1609372800
        )
        XCTAssertGreaterThan(
            "31-12-2020".toDate(format: "yyyy-MM-dd'T'HH:mm:ssZ").toUnixTimestamp(),
            0
        )
    }

    func testFormatDBDateStringToFullDateString() {
        XCTAssertEqual("2020-12-31".formatDBDateStringToFullDateString(), "31 Des 2020")
        XCTAssertEqual("31-12-2020".formatDBDateStringToFullDateString(), "")
    }

    func testFormatInFullDateToDate() {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        XCTAssertEqual("31 Des 2020".formatInFullDateToDate(), dateFormatter.date(from: "2020-12-31")!)
    }

    func testFormatInPeriodValueToDate() {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        XCTAssertEqual("202012".formatInPeriodValueToDate(), dateFormatter.date(from: "2020-12-01")!)
    }

    func testFormatInPeriodDBToDate() {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        XCTAssertEqual("2020-12".formatInPeriodDBToDate(), dateFormatter.date(from: "2020-12-01")!)
    }

    func testFormatInShortDate() {
        dateFormatter.dateFormat = "dd/MM/yyyy"
        XCTAssertEqual("31-12-2020".formatInShortDate(), dateFormatter.date(from: "31/12/2020")!)
    }
}
