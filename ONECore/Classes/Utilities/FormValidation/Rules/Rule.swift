//
//  Rule.swift
//  ONECore
//
//  Created by Sofyan Fradenza Adi on 15/02/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import Foundation

open class Rule: NSObject {
    public var status: ValidationStatus = ValidationStatus()
    public var name: String = DefaultValue.emptyString
    public var message: String = DefaultValue.emptyString

    public init(name: String = DefaultValue.emptyString, message: String = DefaultValue.emptyString) {
        super.init()
        self.name = name
        self.message = message
    }

    open func validate(_ value: String) -> ValidationStatus {
        resetStatus()
        status.isValid = true
        status.message = message
        return status
    }

    open func resetStatus() {
        status = ValidationStatus()
    }
}
