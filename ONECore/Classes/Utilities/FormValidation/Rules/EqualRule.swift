//
//  EqualRule.swift
//  ONECore
//
//  Created by DENZA on 02/03/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import UIKit

public class EqualRule: Rule {
    private var coupleInput: InputProtocol = TextField()

    public init(name: String, coupleInput: InputProtocol, message: String = DefaultValue.emptyString) {
        super.init(name: name, message: message)
        self.coupleInput = coupleInput
        if message != DefaultValue.emptyString { return }
        self.message = String(
            format: ValidationErrorMessage.instance.getErrorMessageFormat(EqualRule.className),
            name,
            coupleInput.name
        )
    }

    override public func validate(_ value: String) -> ValidationStatus {
        status = super.validate(value)
        status.isValid = value == coupleInput.getValue() as? String ?? DefaultValue.emptyString
        return status
    }
}
