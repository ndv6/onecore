//
//  Date+Extension.swift
//  ONECore
//
//  Created by DENZA on 08/03/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import Foundation

extension Date {
    public func formatInMonthAndYear(locale: Locale? = nil) -> String {
        return formatIn(format: DateFormat.monthWithYear, locale: locale)
    }

    public func formatInMonth(locale: Locale? = nil) -> String {
        return formatIn(format: DateFormat.month, locale: locale)
    }

    public func formatInFullDate(locale: Locale? = nil) -> String {
        return formatIn(format: DateFormat.date, locale: locale)
    }

    public func formatInDay(locale: Locale? = nil) -> String {
        return formatIn(format: DateFormat.day, locale: locale)
    }

    public func formatInDayWithMonth(locale: Locale? = nil) -> String {
        return formatIn(format: DateFormat.dayWithMonth, locale: locale)
    }

    public func formatInPeriodDisplay(locale: Locale? = nil) -> String {
        return formatIn(format: DateFormat.periodDisplay, locale: locale)
    }

    public func formatInPeriodValue(locale: Locale? = nil) -> Int {
        return Int(formatIn(format: DateFormat.periodValue, locale: locale)) ?? DefaultValue.emptyInt
    }

    public func formatInPeriodDB(locale: Locale? = nil) -> String {
        return formatIn(format: DateFormat.periodDB, locale: locale)
    }

    public func formatInDBDate(locale: Locale? = nil) -> String {
        return formatIn(format: DateFormat.dBDate, locale: locale)
    }

    public func formatInTime(locale: Locale? = nil) -> String {
        return formatIn(format: DateFormat.time, locale: locale)
    }

    public func formatIn(format: String, locale: Locale? = nil) -> String {
        let formatter = DateFormatter()
        formatter.locale = locale ?? Locale(identifier: Language.bahasa)
        formatter.dateFormat = format
        return formatter.string(from: self)
    }

    public func interval(ofComponent comp: Calendar.Component, fromDate date: Date) -> Int {
        let currentCalendar = Calendar.current
        guard let start = currentCalendar.ordinality(of: comp, in: .era, for: date) else { return 0 }
        guard let end = currentCalendar.ordinality(of: comp, in: .era, for: self) else { return 0 }
        return end - start
    }

    public func getNextYear(_ numberOfYear: Int = 1) -> Date {
        return Calendar.current.date(byAdding: .year, value: numberOfYear, to: self) ?? self
    }

    public func getNextYear(_ numberOfYear: Int = 1) -> Int64 {
        return Int64(getNextYear(numberOfYear).timeIntervalSince1970)
    }

    public func getPreviousYear(_ numberOfYear: Int = 1) -> Date {
        return Calendar.current.date(byAdding: .year, value: numberOfYear * -1, to: self) ?? self
    }

    public func getPreviousYear(_ numberOfYear: Int = 1) -> Int64 {
        return Int64(getPreviousYear(numberOfYear).timeIntervalSince1970)
    }

    public func getNextMonth(_ numberOfMonths: Int = 1) -> Date {
        return Calendar.current.date(byAdding: .month, value: numberOfMonths, to: self) ?? self
    }

    public func getNextMonth(_ numberOfMonths: Int = 1) -> Int64 {
        return Int64(getNextMonth(numberOfMonths).timeIntervalSince1970)
    }

    public func getPreviousMonth(_ numberOfMonths: Int = 1) -> Date {
        return Calendar.current.date(byAdding: .month, value: numberOfMonths * -1, to: self) ?? self
    }

    public func getPreviousMonth(_ numberOfMonths: Int = 1) -> Int64 {
        return Int64(getPreviousMonth(numberOfMonths).timeIntervalSince1970)
    }

    public func getNextDay(_ numberOfDays: Int = 1) -> Date {
        return Calendar.current.date(byAdding: .day, value: numberOfDays, to: self) ?? self
    }

    public func getNextDay(_ numberOfDays: Int = 1) -> Int64 {
        return Int64(getNextDay(numberOfDays).timeIntervalSince1970)
    }

    public func getPreviousDay(_ numberOfDays: Int = 1) -> Date {
        return Calendar.current.date(byAdding: .day, value: numberOfDays * -1, to: self) ?? self
    }

    public func getPreviousDay(_ numberOfDays: Int = 1) -> Int64 {
        return Int64(getPreviousDay(numberOfDays).timeIntervalSince1970)
    }

    public func getNextSecond(_ numberOfSeconds: Int = 1) -> Date {
        return Calendar.current.date(byAdding: .second, value: numberOfSeconds, to: self) ?? self
    }

    public func getNextSecond(_ numberOfSeconds: Int = 1) -> Int64 {
        return Int64(getNextSecond(numberOfSeconds).timeIntervalSince1970)
    }

    public func getFirstDayOfTheMonthInUnixTimestamp() -> Int64 {
        let date = Date()
        let comp: DateComponents = Calendar.current.dateComponents([.year, .month], from: date)
        let startOfMonth = Calendar.current.date(from: comp)!
        return startOfMonth.toUnixTimestamp()
    }

    public static func currentUnixTimestamp() -> Int64 {
        return Int64(Date().timeIntervalSince1970)
    }

    public func toUnixTimestamp() -> Int64 {
        return Int64(self.timeIntervalSince1970)
    }

    public static func fromUnixTimestamp(_ unixTimestamp: Int64) -> Date {
        return Date(timeIntervalSince1970: Double(unixTimestamp))
    }

    public func getTime(interval: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: interval)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = DateFormat.time
        let strDate = dateFormatter.string(from: date)
        return strDate
    }

    public func removeTime() -> Date {
        return self.formatInFullDate().formatInFullDateToDate()
    }

    public static func currentDate() -> Date {
        return Date().removeTime()
    }

    public static func currentDate() -> Int64 {
        return Int64(currentDate().timeIntervalSince1970)
    }

    public func displayRange(until: Date) -> String {
        let startDate = self.toUnixTimestamp() < until.toUnixTimestamp() ? self : until
        let endDate = self.toUnixTimestamp() < until.toUnixTimestamp() ? until : self
        let calendar = Calendar.current
        let startYear = calendar.component(.year, from: startDate)
        let endYear = calendar.component(.year, from: endDate)
        let fullFormat = DateFormatter()
        fullFormat.locale = Locale(identifier: Language.bahasa)
        fullFormat.dateFormat = DateFormat.date
        if startYear == endYear {
            let periodFormat = DateFormatter()
            periodFormat.locale = Locale(identifier: Language.bahasa)
            periodFormat.dateFormat = DateFormat.dayWithMonth
            return "\(periodFormat.string(from: startDate)) \(Separator.rangePeriod) \(fullFormat.string(from: endDate))"
        }
        return "\(fullFormat.string(from: startDate)) \(Separator.rangePeriod) \(fullFormat.string(from: endDate))"
    }

    public func getHumanDate(interval: TimeInterval, todayText: String, yesterdayText: String) -> String {
        let calendar = Calendar.current
        let date = Date(timeIntervalSince1970: interval)
        if calendar.isDateInYesterday(date) {
            return yesterdayText
        }
        if calendar.isDateInToday(date) {
            return todayText
        }
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = DateFormat.date
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
}
