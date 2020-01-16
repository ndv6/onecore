//
//  PersonNameRule.swift
//  ONECore
//
//  Created by Steven Tiolie on 13/03/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import Foundation

public class PersonNameRule: Rule {
    override public init(name: String, message: String = DefaultValue.emptyString) {
        super.init(name: name, message: message)
        if message != DefaultValue.emptyString { return }
        self.message = String(
            format: ValidationErrorMessage.instance.getErrorMessageFormat(PersonNameRule.className),
            name
        )
    }

    override public func validate(_ value: String) -> ValidationStatus {
        status = super.validate(value)
        status.isValid = value.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).isValid(regexRule: RegexString.personName)
        return status
    }
}
