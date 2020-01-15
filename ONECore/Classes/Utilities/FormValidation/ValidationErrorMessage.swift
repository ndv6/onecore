//
//  ValidationErrorMessage.swift
//  ONECore
//
//  Created by DENZA on 08/03/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import Foundation

public class ValidationErrorMessage {
    public static let instance = ValidationErrorMessage()
    private var errorMessageFormats = [String: String]()

    public func setErrorMessageFormats(_ errorMessageFormats: [String: String]) {
        self.errorMessageFormats = errorMessageFormats
    }

    public func getErrorMessageFormat(_ owner: String) -> String {
        for (key, value) in errorMessageFormats where key == owner {
            return value
        }
        return DefaultValue.emptyString
    }
}
