//
//  ErrorResponse.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 07/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import ONECore
import ObjectMapper

public struct ErrorResponse {
    public var code: String = DefaultValue.emptyString
    public var message: String = DefaultValue.emptyString

    public init(code: String = DefaultValue.emptyString, message: String = DefaultValue.emptyString) {
        self.code = code
        self.message = message
    }
}

extension ErrorResponse: Mappable {
    public init?(map: Map) { self.init() }

    public mutating func mapping(map: Map) {
        code <- map["error.code"]
        message <- map["error.message"]
    }
}
