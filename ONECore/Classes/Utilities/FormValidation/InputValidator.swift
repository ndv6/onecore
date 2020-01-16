//
//  InputValidator.swift
//  ONECore
//
//  Created by Sofyan Fradenza Adi on 15/02/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import Foundation

public class InputValidator {
    var input: InputProtocol = TextField()
    var rules: [Rule] = [Rule]()

    public init(input: InputProtocol, rules: [Rule] = [Rule]()) {
        self.input = input
        self.rules = rules
    }

    public func validate(ruleType: AnyClass? = nil, isNeedToTrackResult: Bool = true) -> ValidationStatus {
        var result = ValidationStatus()
        for rule in rules {
            if ruleType != nil && !rule.isKind(of: ruleType!) { continue }
            let status = rule.validate(input.getText())
            if !isNeedToTrackResult {
                rule.resetStatus()
            }
            if !status.isValid {
                result = status
                break
            }
        }
        return result
    }

    public func getLastStatus() -> ValidationStatus {
        for rule in rules where !rule.status.isValid {
            return rule.status
        }
        return ValidationStatus()
    }
}
