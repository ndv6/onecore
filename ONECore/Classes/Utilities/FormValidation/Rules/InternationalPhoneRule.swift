//
//  InternationalPhoneRule.swift
//  Alamofire
//
//  Created by Steven Tiolie on 04/10/19.
//

import UIKit

public class InternationalPhoneRule: Rule {
    override public init(name: String, message: String = DefaultValue.emptyString) {
        super.init(name: name, message: message)
        if message != DefaultValue.emptyString { return }
        self.message = String(
            format: ValidationErrorMessage.instance.getErrorMessageFormat(InternationalPhoneRule.className),
            name
        )
    }
    
    override public func validate(_ value: String) -> ValidationStatus {
        status = super.validate(value)
        status.isValid = value.prefix(1) == "+" && value.count >= 10 && value.count <= 13
        return status
    }
}
