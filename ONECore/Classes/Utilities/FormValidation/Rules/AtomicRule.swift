//
//  AtomicRule.swift
//  ONECore
//
//  Created by DENZA on 03/03/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import UIKit

public class AtomicRule: Rule {
    private var coupleInputs: [InputProtocol] = [InputProtocol]()
    private var extraValidator: InputValidator?

    public init(name: String, coupleInputs: [InputProtocol], extraValidator: InputValidator? = nil, message: String = DefaultValue.emptyString) {
        super.init(name: name, message: message)
        self.coupleInputs = coupleInputs
        self.extraValidator = extraValidator
        if message != DefaultValue.emptyString { return }
        self.message = String(format: ValidationErrorMessage.instance.getErrorMessageFormat(AtomicRule.className), name)
    }

    override public func validate(_ value: String) -> ValidationStatus {
        status = super.validate(value)
        if value.isEmpty {
            for coupleInput in coupleInputs {
                if !coupleInput.getText().isEmpty {
                    status.isValid = false
                    return status
                }
            }
        } else if let extraValidator = extraValidator {
            return extraValidator.validate()
        }
        return status
    }
}
