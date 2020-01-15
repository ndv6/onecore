//
//  TextFieldStyle.swift
//  ONECore
//
//  Created by DENZA on 08/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

public protocol TextFieldStyle {
    var font: UIFont { get }
    var color: UIColor { get }
    var placeholderColor: UIColor { get }
    var backgroundColor: UIColor { get }
    var borderStyle: FieldBorderStyle { get }
    var borderColor: UIColor { get }
    var borderWidth: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var padding: UIEdgeInsets { get }
    var tintColor: UIColor { get }
}
