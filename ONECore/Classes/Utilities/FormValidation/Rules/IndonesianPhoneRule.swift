//
//  IndonesianPhoneRule.swift
//  ONECore
//
//  Created by DENZA on 01/03/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import UIKit

public class IndonesianPhoneRule: Rule {
    override public init(name: String, message: String = DefaultValue.emptyString) {
        super.init(name: name, message: message)
        if message != DefaultValue.emptyString { return }
        self.message = String(
            format: ValidationErrorMessage.instance.getErrorMessageFormat(IndonesianPhoneRule.className),
            name
        )
    }

    override public func validate(_ value: String) -> ValidationStatus {
        status = super.validate(value)
        status.isValid = (
            value.prefix(2) == "08"
<<<<<<< HEAD
                || value.prefix(2) == "62"
                || value.prefix(3) == "+62"
        ) && value.count >= 10 && value.count <= 14
=======
            || value.prefix(2) == "62"
            || value.prefix(3) == "+62"
        ) && value.count >= 10 && value.count <= 13
>>>>>>> fix 100 warnings
        return status
    }
}
