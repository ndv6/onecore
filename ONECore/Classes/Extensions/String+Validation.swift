//
//  String+Validation.swift
//  ONECore
//
//  Created by Sofyan Fradenza Adi on 29/10/19.
//

import Foundation

extension String {
    public func isValidURL() -> Bool {
        if let url = NSURL(string: self) {
            return UIApplication.shared.canOpenURL(url as URL)
        }
        return false
    }

    public func isValid(regexRule: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", regexRule).evaluate(with: self)
    }

    public func isBackspace() -> Bool {
        guard let char = self.cString(using: String.Encoding.utf8) else { return false }
        return strcmp(char, "\\b") == -92
    }
}
