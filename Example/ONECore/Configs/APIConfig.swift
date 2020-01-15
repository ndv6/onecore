//
//  APIConfig.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 06/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import ONECore

internal struct APIConfig {
    static var baseUrl: String {
        return Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String ?? DefaultValue.emptyString
    }
}
