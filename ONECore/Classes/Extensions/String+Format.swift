//
//  String+Format.swift
//  ONECore
//
//  Created by Sofyan Fradenza Adi on 29/10/19.
//

import Foundation

extension String {
    static let numberFormatter = NumberFormatter()

    subscript (idx: Int) -> String {
        if isEmpty || idx >= count { return DefaultValue.emptyString }
        return String(self[index(startIndex, offsetBy: idx)])
    }

    public var doubleValue: Double {
        String.numberFormatter.decimalSeparator = Separator.decimalEN
        if let result =  String.numberFormatter.number(from: self) {
            return result.doubleValue
        } else {
            String.numberFormatter.decimalSeparator = Separator.decimalID
            if let result = String.numberFormatter.number(from: self) {
                return result.doubleValue
            }
        }
        return DefaultValue.emptyDouble
    }

    public var floatValue: Float {
        String.numberFormatter.decimalSeparator = Separator.decimalEN
        if let result =  String.numberFormatter.number(from: self) {
            return result.floatValue
        } else {
            String.numberFormatter.decimalSeparator = Separator.decimalID
            if let result = String.numberFormatter.number(from: self) {
                return result.floatValue
            }
        }
        return DefaultValue.emptyFloat
    }

    public var integerValue: Int {
        return Int(self.digits) ?? DefaultValue.emptyInt
    }

    public var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }

    public func withThousandSeparator() -> String {
        return Formatter.thousandSeparator.string(for: Int(self.digits)) ?? DefaultValue.emptyString
    }

    public func formatInIndonesianMobilePhone() -> String {
        var number = self.digits
        if !self.hasPrefix("+") && !number.hasPrefix("62") { return number }
        number = "+" + number
        let prefix = "+" + CountryCode.indonesia
        if number.hasPrefix(prefix) {
            number = String(number.dropFirst(prefix.count))
            number = "0" + number
        }
        return number
    }

    public func toAccessibilityFormat() -> String {
        return self.replacingOccurrences(
            of: Separator.whitespace,
            with: Separator.accessibilityId
            ).lowercased()
    }

    public func removeAllWhitespaces() -> String {
        return String(self.filter { !" \n\t\r".contains($0) })
    }

    public func getSuffix(_ maxLength: Int) -> String {
        var length = maxLength
        if self.count < maxLength {
            length = self.count
        }
        return String(suffix(length))
    }

    public func getPrefix(_ maxLength: Int) -> String {
        var length = maxLength
        if self.count < maxLength {
            length = self.count
        }
        return String(prefix(length))
    }

    public func getFirstWord() -> String {
        return components(separatedBy: DefaultValue.whitespace).first ?? DefaultValue.emptyString
    }

    public mutating func append(
        text: String,
        separator: String = DefaultValue.emptyString
    ) {
        if text.isEmpty { return }
        if !self.isEmpty { self += separator }
        self += text
    }

    public var removeMultipleWhitespaces: String {
        let components = self.components(separatedBy: NSCharacterSet.whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: DefaultValue.whitespace)
    }

    public func filterAllowedCharacters(_ allowedCharacters: String) -> String {
        let rejectedCharacters = NSCharacterSet(charactersIn: allowedCharacters).inverted
        let filteredCharacters = components(separatedBy: rejectedCharacters)
        return filteredCharacters.joined(separator: DefaultValue.emptyString)
    }

    public func appendLeading(
        withCharacter character: Character,
        targetLength: Int
    ) -> String {
        var prefix = DefaultValue.emptyString
        var prefixLength = targetLength - count
        while prefixLength > 0 {
            prefix += String(character)
            prefixLength -= 1
        }
        return prefix + self
    }
}
