//
//  MinIntegerRule.swift
//  ONECore
//
//  Created by Sofyan Fradenza Adi on 15/02/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import Foundation

public class MinIntegerRule: Rule {
    private var minValue: Int = 0

    public init(name: String, minValue: Int, message: String = DefaultValue.emptyString) {
        super.init(name: name, message: message)
        self.minValue = minValue
        if message != DefaultValue.emptyString { return }
        self.message = String(
            format: ValidationErrorMessage.instance.getErrorMessageFormat(MinIntegerRule.className),
            name,
            String(minValue)
        )
    }

    override public func validate(_ value: String) -> ValidationStatus {
        status = super.validate(value)
        let number = Int(value.digits) ?? DefaultValue.emptyInt
        status.isValid = number >= minValue
        return status
    }
}
