//
//  NSObject+Extension.swift
//  ONECore
//
//  Created by DENZA on 08/03/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import Foundation

extension NSObject {
    public var className: String {
        return String(describing: type(of: self)).components(separatedBy: ".").last ?? DefaultValue.emptyString
    }

    public class var className: String {
        return String(describing: self).components(separatedBy: ".").last ?? DefaultValue.emptyString
    }
}
