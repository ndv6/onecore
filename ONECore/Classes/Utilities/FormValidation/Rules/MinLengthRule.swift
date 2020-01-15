//
//  MinLengthRule.swift
//  ONECore
//
//  Created by Sofyan Fradenza Adi on 15/02/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import Foundation

public class MinLengthRule: Rule {
    private var minLength: Int = 0

    public init(name: String, minLength: Int, message: String = DefaultValue.emptyString) {
        super.init(name: name, message: message)
        self.minLength = minLength
        if message != DefaultValue.emptyString { return }
        self.message = String(
            format: ValidationErrorMessage.instance.getErrorMessageFormat(MinLengthRule.className),
            name,
            String(minLength)
        )
    }

    override public func validate(_ value: String) -> ValidationStatus {
        status = super.validate(value)
        status.isValid = value.count >= minLength
        return status
    }
}
