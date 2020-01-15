//
//  SanitizeRule.swift
//  ONECore
//
//  Created by Sofyan Fradenza Adi on 15/02/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import Foundation

public class SanitizeRule: Rule {
    private var rejectedValues: [String] = [String]()

    public init(name: String, rejectedValues: [String] = [String](), message: String = DefaultValue.emptyString) {
        super.init(name: name, message: message)
        self.rejectedValues = rejectedValues
    }

    override public func validate(_ value: String) -> ValidationStatus {
        status = super.validate(value)
        status.isValid = !rejectedValues.contains(value)
        if self.message == DefaultValue.emptyString {
            status.message = String(
                format: ValidationErrorMessage.instance.getErrorMessageFormat(SanitizeRule.className),
                name,
                value
            )
        }
        return status
    }
}
