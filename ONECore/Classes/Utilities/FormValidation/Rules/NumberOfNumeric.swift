//
//  NumberOfNumeric.swift
//  ONECore
//
//  Created by DENZA on 15/09/19.
//

import UIKit

public class NumberOfNumeric: Rule {
    private var numberOfNumeric: Int = 0

    public init(name: String, numberOfNumeric: Int, message: String = DefaultValue.emptyString) {
        super.init(name: name, message: message)
        self.numberOfNumeric = numberOfNumeric
        if message != DefaultValue.emptyString { return }
        self.message = String(
            format: ValidationErrorMessage.instance.getErrorMessageFormat(NumberOfNumeric.className),
            name,
            String(numberOfNumeric)
        )
    }

    override public func validate(_ value: String) -> ValidationStatus {
        status = super.validate(value)
        var numericCounter = 0
        for letter in value.unicodeScalars where 48...57 ~= letter.value {
            numericCounter += 1
        }
        status.isValid = numericCounter == numberOfNumeric
        return status
    }
}
