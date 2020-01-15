//
//  InvisibleTextFieldStyle.swift
//  ONECore
//
//  Created by DENZA on 21/09/19.
//

import UIKit

open class InvisibleTextFieldStyle: TextFieldStyle {
    open var font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
    open var color = UIColor.clear
    open var placeholderColor = UIColor.clear
    open var backgroundColor = UIColor.clear
    open var borderStyle = FieldBorderStyle.none
    open var borderColor = UIColor.clear
    open var borderWidth = CGFloat(0)
    open var cornerRadius = DefaultValue.emptyCGFloat
    open var padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    open var tintColor = UIColor.clear
    public init() {}
}
