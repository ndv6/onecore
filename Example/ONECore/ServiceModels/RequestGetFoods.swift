//
//  RequestGetFoods.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 07/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import ONECore
import ObjectMapper

struct RequestGetFoods {}

extension RequestGetFoods: Mappable {
    public init?(map: Map) { self.init() }

    public mutating func mapping(map: Map) {}
}
