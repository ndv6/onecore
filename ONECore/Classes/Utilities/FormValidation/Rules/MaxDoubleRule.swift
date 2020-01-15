//
//  MaxDoubleRule.swift
//  Alamofire
//
//  Created by Sofyan Fradenza Adi on 30/04/19.
//

import UIKit

import Foundation

public class MaxDoubleRule: Rule {
    private var maxValue: Double = 0

    public init(name: String, maxValue: Double, message: String = DefaultValue.emptyString) {
        super.init(name: name, message: message)
        self.maxValue = maxValue
        if message != DefaultValue.emptyString { return }
        self.message = String(
            format: ValidationErrorMessage.instance.getErrorMessageFormat(MaxDoubleRule.className),
            name,
            maxValue.clean
        )
    }

    override public func validate(_ value: String) -> ValidationStatus {
        status = super.validate(value)
        status.isValid = value.doubleValue <= maxValue
        return status
    }
}
