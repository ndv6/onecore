//
//  RegexString.swift
//  ONECore
//
//  Created by Steven Tiolie on 13/03/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import Foundation

public struct RegexString {
    public static let password = "^(?=.*\\d)(?=.*[a-zA-Z]).{6,}$"
    public static let personName = "^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$"
    public static let email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    public static let alphanumeric = "^[a-zA-Z0-9]*$"
}
