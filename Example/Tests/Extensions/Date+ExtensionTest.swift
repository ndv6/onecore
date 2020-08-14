//
//  Date+ExtensionTests.swift
//  OLCoreExtensionTests
//
//  Created by Sofyan Fradenza Adi on 17/12/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest

class DateExtensionTest: XCTestCase {
    let locale = Locale(identifier: "en_US_POSIX")
    let dateFormatter = DateFormatter()
    var date = Date()

    override func setUp() {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = locale
        date = dateFormatter.date(from: "2020-12-31T00:00:00+0000")!
    }

    func testFormatInMonthAndYear() {
        XCTAssertEqual(date.formatInMonthAndYear(), "Desember 2020")
    }

    func testFormatInMonth() {
        XCTAssertEqual(date.formatInMonth(), "Des")
    }

    func testFormatInFullDate() {
        XCTAssertEqual(date.formatInFullDate(), "31 Des 2020")
    }

    func testFormatInDay() {
        XCTAssertEqual(date.formatInDay(), "31")
    }

    func testFormatInDayWithMonth() {
        XCTAssertEqual(date.formatInDayWithMonth(), "31 Des")
    }

    func testFormatInPeriodDisplay() {
        XCTAssertEqual(date.formatInPeriodDisplay(), "Des 2020")
    }

    func testFormatInPeriodValue() {
        XCTAssertEqual(date.formatInPeriodValue(), 202012)
    }

    func testFormatInPeriodDB() {
        XCTAssertEqual(date.formatInPeriodDB(), "2020-12")
    }

    func testFormatInDBDate() {
        XCTAssertEqual(date.formatInDBDate(), "2020-12-31")
    }

    func testFormatInDayTime() {
        XCTAssertEqual(date.formatInDayTime(), "31 Desember 2021 07:00")
    }

    func testFormatInDayAndTime() {
        XCTAssertEqual(date.formatInDayAndTime(), "31 Des 2020, 07:00 AM")
    }

    func testFormatInShortDate() {
        XCTAssertEqual(date.formatInShortDate(), "31/12/2020")
    }

    func testFormatIn() {
        XCTAssertEqual(date.formatIn(format: "dd MMM yyyy", locale: locale), "31 Dec 2020")
        XCTAssertEqual(date.formatIn(format: "dd MMM yyyy"), "31 Des 2020")
    }

    func testInterval() {
        let startDate = dateFormatter.date(from: "2020-12-11T00:00:00+0000")!
        XCTAssertEqual(date.interval(ofComponent: Calendar.Component.day, fromDate: startDate), 20)
    }

    func testGetNextYear() {
        let resultDate: Date = date.getNextYear()
        let resultUnixtime: Int64 = date.getNextYear()
        XCTAssertEqual(resultDate, dateFormatter.date(from: "2021-12-31T00:00:00+0000")!)
        XCTAssertEqual(resultUnixtime, 1640908800)
    }

    func testGetPreviousYear() {
        let resultDate: Date = date.getPreviousYear()
        let resultUnixtime: Int64 = date.getPreviousYear()
        XCTAssertEqual(resultDate, dateFormatter.date(from: "2019-12-31T00:00:00+0000")!)
        XCTAssertEqual(resultUnixtime, 1577750400)
    }

    func testGetNextMonth() {
        let resultDate: Date = date.getNextMonth()
        let resultUnixtime: Int64 = date.getNextMonth()
        XCTAssertEqual(resultDate, dateFormatter.date(from: "2021-01-31T00:00:00+0000")!)
        XCTAssertEqual(resultUnixtime, 1612051200)
    }

    func testGetPreviousMonth() {
        let resultDate: Date = date.getPreviousMonth()
        let resultUnixtime: Int64 = date.getPreviousMonth()
        XCTAssertEqual(resultDate, dateFormatter.date(from: "2020-11-30T00:00:00+0000")!)
        XCTAssertEqual(resultUnixtime, 1606694400)
    }

    func testGetNextDay() {
        let resultDate: Date = date.getNextDay()
        let resultUnixtime: Int64 = date.getNextDay()
        XCTAssertEqual(resultDate, dateFormatter.date(from: "2021-01-01T00:00:00+0000")!)
        XCTAssertEqual(resultUnixtime, 1609459200)
    }

    func testGetPreviousDay() {
        let resultDate: Date = date.getPreviousDay()
        let resultUnixtime: Int64 = date.getPreviousDay()
        XCTAssertEqual(resultDate, dateFormatter.date(from: "2020-12-30T00:00:00+0000")!)
        XCTAssertEqual(resultUnixtime, 1609286400)
    }

    func testGetNextSecond() {
        let resultDate: Date = date.getNextSecond()
        let resultUnixtime: Int64 = date.getNextSecond()
        XCTAssertEqual(resultDate, dateFormatter.date(from: "2020-12-31T00:00:01+0000")!)
        XCTAssertEqual(resultUnixtime, 1609372801)
    }

    func testToUnixTimestamp() {
        XCTAssertEqual(date.toUnixTimestamp(), 1609372800)
    }

    func testGetTime() {
        XCTAssertEqual(date.getTime(interval: 1000), "07:16")
    }

    func testDisplayRange() {
        let startDate = dateFormatter.date(from: "2020-08-20T00:00:00+0000")!
        XCTAssertEqual(
            startDate.displayRange(until: dateFormatter.date(from: "2020-10-21T00:00:00+0000")!),
            "20 Agu - 21 Okt 2020"
        )
        XCTAssertEqual(
            startDate.displayRange(until: dateFormatter.date(from: "2021-10-21T00:00:00+0000")!),
            "20 Agu 2020 - 21 Okt 2021"
        )
        XCTAssertEqual(
            startDate.displayRange(until: dateFormatter.date(from: "2020-08-10T00:00:00+0000")!),
            "10 Agu - 20 Agu 2020"
        )
        XCTAssertEqual(
            startDate.displayRange(until: dateFormatter.date(from: "2019-03-16T00:00:00+0000")!),
            "16 Mar 2019 - 20 Agu 2020"
        )
    }

    func testFromUnixTimestamp() {
        let expected = Date(timeIntervalSince1970: 946684800.0)
        XCTAssertEqual(
            Date.fromUnixTimestamp(946684800),
            expected
        )
    }

    func testRemoveTime() {
        let input = Date(timeIntervalSince1970: 946684800.0)
        let expected = Date(timeIntervalSince1970: 946659600.0)
        XCTAssertEqual(
            input.removeTime(),
            expected
        )
    }

    func testGetHuman() {
        let expected = "01 Jan 2000"
        XCTAssertEqual(
            Date().getHumanDate(interval: 946684800.0, todayText: "Today", yesterdayText: "Yesterday"),
            expected
        )
    }

    func testGetHumanToday() {
        let todayInterval = Date().timeIntervalSince1970
        let expected = "Today"
        XCTAssertEqual(
            Date().getHumanDate(
                interval: todayInterval,
                todayText: "Today",
                yesterdayText: "Yesterday"
            ),
            expected
        )
    }

    func testGetHumanYesterday() {
        let yesterdayInterval = Date().removeTime().addingTimeInterval(-3600).timeIntervalSince1970
        let expected = "Yesterday"
        XCTAssertEqual(
            Date().getHumanDate(
                interval: yesterdayInterval,
                todayText: "Today",
                yesterdayText: "Yesterday"
            ),
            expected
        )
    }

    func testCurrentUnixTimestamp() {
        let expected = Int64(Date().timeIntervalSince1970)
        XCTAssertEqual(
            Date.currentUnixTimestamp(),
            expected
        )
    }

    func testCurrentDate() {
        let expected = Date().removeTime()
        XCTAssertEqual(
            Date.currentDate(),
            expected
        )
    }

    func testCurrentDateInt64() {
        let expected = Int64(Date().removeTime().timeIntervalSince1970)
        XCTAssertEqual(
            Date.currentDate(),
            expected
        )
    }

    func testFormatInTime() {
        let input = Date(timeIntervalSince1970: 946684800.0)
        let expected = "07:00"
        XCTAssertEqual(
            input.formatInTime(),
            expected
        )
    }

    func testFormatInTimePeriod() {
        let input = Date(timeIntervalSince1970: 946684800.0)
        let expected = "07:00 AM"
        XCTAssertEqual(
            input.formatInTimePeriod(),
            expected
        )
    }
}
