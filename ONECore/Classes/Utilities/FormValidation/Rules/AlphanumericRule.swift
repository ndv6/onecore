//
//  AlphanumericRule.swift
//  ONECore
//
//  Created by DENZA on 14/09/19.
//

import UIKit

public class AlphanumericRule: Rule {
    override public init(name: String, message: String = DefaultValue.emptyString) {
        super.init(name: name, message: message)
        if message != DefaultValue.emptyString { return }
        self.message = String(
            format: ValidationErrorMessage.instance.getErrorMessageFormat(AlphanumericRule.className),
            name
        )
    }

    override public func validate(_ value: String) -> ValidationStatus {
        status = super.validate(value)
        status.isValid = value.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).isValid(regexRule: RegexString.alphanumeric)
        return status
    }
}
