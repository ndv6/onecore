//
//  Option.swift
//  ONECore
//
//  Created by DENZA on 24/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

open class Option {
    public var id: String = DefaultValue.emptyString
    public var tag: String = DefaultValue.emptyString
    public var text: String = DefaultValue.emptyString
    public var value: Any
    public var description: String = DefaultValue.emptyString
    public var isNoteRequired: Bool = false
    public var isActive: Bool = true

    public init(
        id: String = DefaultValue.emptyString,
        text: String = DefaultValue.emptyString,
        isActive: Bool = true,
        description: String = DefaultValue.emptyString,
        value: Any = DefaultValue.emptyAny,
        tag: String = DefaultValue.emptyString,
        isNoteRequired: Bool = false
    ) {
        self.id = id
        self.text = text
        self.isActive = isActive
        self.description = description
        self.value = value
        self.tag = tag
        self.isNoteRequired = isNoteRequired
    }
}
