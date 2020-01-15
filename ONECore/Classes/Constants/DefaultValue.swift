//
//  DefaultValue.swift
//  ONECore
//
//  Created by DENZA on 08/03/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import Foundation

public struct DefaultValue {
    public static let placeholder = "-"
    public static let whitespace = " "
    public static let emptyString = ""
    public static let emptyInt = 0
    public static let emptyTimeInterval = TimeInterval(0)
    public static let emptyInt32 = Int32(0)
    public static let emptyInt64 = Int64(0)
    public static let emptyUInt = UInt(0)
    public static let emptyDouble = Double(0.0)
    public static let emptyFloat = Float(0.0)
    public static let emptyIndex = -1
    public static let emptyCGFloat = CGFloat(0.0)
    public static let emptyAny = DefaultValue.emptyString as Any
}
