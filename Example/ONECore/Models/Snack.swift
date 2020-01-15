//
//  Snack.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 10/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import ONECore
import ObjectMapper

struct Snack {
    var id: String = DefaultValue.emptyString
    var title: String = DefaultValue.emptyString
    var imageLink: String = DefaultValue.emptyString
}

extension Snack: Mappable {
    public init?(map: Map) { self.init() }

    public mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        imageLink <- map["image_link"]
    }
}
