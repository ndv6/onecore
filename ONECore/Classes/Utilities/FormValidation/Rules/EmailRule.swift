//
//  EmailRule.swift
//  ONEOnboard
//
//  Created by Sofyan Fradenza Adi on 29/08/19.
//

import UIKit

public class EmailRule: Rule {
    override public init(name: String, message: String = DefaultValue.emptyString) {
        super.init(name: name, message: message)
        if message != DefaultValue.emptyString { return }
        self.message = String(
            format: ValidationErrorMessage.instance.getErrorMessageFormat(EmailRule.className),
            name
        )
    }

    override public func validate(_ value: String) -> ValidationStatus {
        status = super.validate(value)
        status.isValid = value.trimmingCharacters(in: .whitespacesAndNewlines).isValid(regexRule: RegexString.email)
        return status
    }
}
