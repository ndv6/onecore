//
//  Double+Extension.swift
//  ONECore
//
//  Created by DENZA on 07/12/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import Foundation

extension Double {
    public var clean: String {
        let rounded = self.rounded(toPlaces: 3)
        return rounded.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", rounded) : String(rounded)
    }

    public func toCurrencyIDR() -> String {
        let string = "Rp \(String(Int(self)).withThousandSeparator())"
        if self < 0 {
            return "-\(string)"
        }
        return string
    }

    public func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }

    public func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        let last = String(self).components(separatedBy: ".").last ?? DefaultValue.emptyString
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = last.count
        return String(formatter.string(from: number) ?? DefaultValue.emptyString)
    }
}
