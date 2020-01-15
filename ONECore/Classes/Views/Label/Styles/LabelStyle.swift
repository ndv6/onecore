//
//  LabelStyle.swift
//  ONECore
//
//  Created by DENZA on 08/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

public protocol LabelStyle {
    var textFont: UIFont { get }
    var textColor: UIColor { get }
    var alignment: NSTextAlignment { get }
}
