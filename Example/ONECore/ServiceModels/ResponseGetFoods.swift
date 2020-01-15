//
//  ResponseGetFoods.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 07/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import ONECore
import ObjectMapper

struct ResponseGetFoods {
    var foods: [Food] = [Food]()
}

extension ResponseGetFoods: Mappable {
    public init?(map: Map) { self.init() }

    public mutating func mapping(map: Map) {
        foods <- map["content.foods"]
    }
}
