//
//  RegularTextFieldStyle.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 04/03/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import ONECore

class RegularTextFieldStyle: TextFieldStyle {
    var font = UIFont.systemFont(ofSize: FontSize.paragraph2, weight: .regular)
    var color = Colors.primary
    var placeholderColor = Colors.gray
    var backgroundColor = Colors.white
    var borderStyle = FieldBorderStyle.bottomLine
    var borderColor = Colors.gray
    var borderWidth = CGFloat(1)
    var cornerRadius = DefaultValue.emptyCGFloat
    var padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    var tintColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0)
}
