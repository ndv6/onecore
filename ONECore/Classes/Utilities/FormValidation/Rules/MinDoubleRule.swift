//
//  MinDoubleRule.swift
//  Alamofire
//
//  Created by Sofyan Fradenza Adi on 30/04/19.
//

import Foundation

public class MinDoubleRule: Rule {
    private var minValue: Double = 0

    public init(name: String, minValue: Double, message: String = DefaultValue.emptyString) {
        super.init(name: name, message: message)
        self.minValue = minValue
        if message != DefaultValue.emptyString { return }
        self.message = String(
            format: ValidationErrorMessage.instance.getErrorMessageFormat(MinDoubleRule.className),
            name,
            minValue.clean
        )
    }

    override public func validate(_ value: String) -> ValidationStatus {
        status = super.validate(value)
        status.isValid = value.doubleValue >= minValue
        return status
    }
}
