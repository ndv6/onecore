//
//  MaxIntegerRule.swift
//  ONECore
//
//  Created by Sofyan Fradenza Adi on 15/02/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import Foundation

public class MaxIntegerRule: Rule {
    private var maxValue: Int = 0

    public init(name: String, maxValue: Int, message: String = DefaultValue.emptyString) {
        super.init(name: name, message: message)
        self.maxValue = maxValue
        if message != DefaultValue.emptyString { return }
        self.message = String(
            format: ValidationErrorMessage.instance.getErrorMessageFormat(MaxIntegerRule.className),
            name,
            String(maxValue)
        )
    }

    override public func validate(_ value: String) -> ValidationStatus {
        status = super.validate(value)
        let number = Int(value.digits) ?? DefaultValue.emptyInt
        status.isValid = number <= maxValue
        return status
    }
}
