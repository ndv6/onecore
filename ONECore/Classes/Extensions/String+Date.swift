//
//  String+Date.swift
//  ONECore
//
//  Created by Sofyan Fradenza Adi on 29/10/19.
//

import Foundation

extension String {
    public func toDate(format: String) -> Date {
        let dateFormatter = DateHelper.dateFormatter
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self) ?? Date()
    }

    public func formatDBDateStringToFullDateString() -> String {
        let dateFormatter = DateHelper.dateFormatter
        dateFormatter.dateFormat = DateFormat.dBDate
        guard let date = dateFormatter.date(from: self) else {
            return DefaultValue.emptyString
        }
        dateFormatter.dateFormat = DateFormat.date
        return dateFormatter.string(from: date)
    }

    public func formatInFullDateToDate() -> Date {
        return self.toDate(format: DateFormat.date)
    }

    public func formatInPeriodValueToDate() -> Date {
        return self.toDate(format: DateFormat.periodValue)
    }

    public func formatInPeriodDBToDate() -> Date {
        return self.toDate(format: DateFormat.periodDB)
    }

    public func formatInShortDate() -> Date {
        return self.toDate(format: DateFormat.shortDate)
    }
}
