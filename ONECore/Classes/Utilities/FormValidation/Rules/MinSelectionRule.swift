//
//  MinSelectionRule.swift
//  Kelolala
//
//  Created by Sofyan Fradenza Adi on 23/05/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import UIKit

public class MinSelectionRule: Rule {
    private var minSelected: Int = 0

    public init(name: String, minSelected: Int, message: String = DefaultValue.emptyString) {
        super.init(name: name, message: message)
        self.minSelected = minSelected
        if message != DefaultValue.emptyString { return }
        self.message = String(
            format: ValidationErrorMessage.instance.getErrorMessageFormat(MinSelectionRule.className),
            String(minSelected),
            name
        )
    }

    override public func validate(_ value: String) -> ValidationStatus {
        status = super.validate(value)
        status.isValid = !value.trimmingCharacters(in: .whitespaces).isEmpty
            && value.components(separatedBy: Separator.phrase).count >= minSelected
        return status
    }
}
