//
//  ResponseGetSnacks.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 13/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import ONECore
import ObjectMapper

struct ResponseGetSnacks {
    var snacks: [Snack] = [Snack]()
}

extension ResponseGetSnacks: Mappable {
    public init?(map: Map) { self.init() }

    public mutating func mapping(map: Map) {
        snacks <- map["content.snacks"]
    }
}
