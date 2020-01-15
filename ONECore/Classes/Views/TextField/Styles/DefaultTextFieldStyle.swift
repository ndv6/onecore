//
//  DefaultTextFieldStyle.swift
//  ONECore
//
//  Created by DENZA on 21/09/19.
//

import UIKit

open class DefaultTextFieldStyle: TextFieldStyle {
    open var font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
    open var color = UIColor.black
    open var placeholderColor = UIColor.lightGray
    open var backgroundColor = UIColor.white
    open var borderStyle = FieldBorderStyle.bottomLine
    open var borderColor = UIColor.gray
    open var borderWidth = CGFloat(1)
    open var cornerRadius = DefaultValue.emptyCGFloat
    open var padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    open var tintColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0)
    public init() {}
}
