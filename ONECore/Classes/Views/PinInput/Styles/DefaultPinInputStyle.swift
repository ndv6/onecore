//
//  DefaultPinInputStyle.swift
//  ONECore
//
//  Created by DENZA on 21/09/19.
//

import UIKit

open class DefaultPinInputStyle: PinInputStyle {
    open var font = UIFont.systemFont(ofSize: UIFont.labelFontSize)
    open var textColor = UIColor.black
    open var backgroundColor = UIColor.clear
    open var borderColor = UIColor.clear
    open var borderWidth = CGFloat(0)
    open var cornerRadius = CGFloat(0)
    open var bottomLineColor = UIColor.black
    open var bottomLineWidth = CGFloat(1)
    public init() {}
}
