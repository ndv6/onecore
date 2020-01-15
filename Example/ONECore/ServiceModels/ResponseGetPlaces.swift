//
//  ResponseGetPlaces.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 13/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import ONECore
import ObjectMapper

struct ResponseGetPlaces {
    var places: [Place] = [Place]()
}

extension ResponseGetPlaces: Mappable {
    public init?(map: Map) { self.init() }

    public mutating func mapping(map: Map) {
        places <- map["content.places"]
    }
}
