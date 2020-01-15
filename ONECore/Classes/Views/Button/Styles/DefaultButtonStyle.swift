//
//  DefaultButtonStyle.swift
//  ONECore
//
//  Created by Sofyan Fradenza Adi on 11/03/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import UIKit

open class DefaultButtonStyle: ButtonStyle {
    open var textFont = UIFont.systemFont(ofSize: UIFont.buttonFontSize)
    open var textColorEnabled = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0)
    open var textColorDisabled = UIColor.gray
    open var textAlignment = NSTextAlignment.center
    open var buttonColorEnabled = UIColor.clear
    open var buttonColorDisabled = UIColor.clear
    open var buttonGradientColorsEnabled = [UIColor]()
    open var buttonGradientColorsDisabled = [UIColor]()
    open var buttonGradientStartPoint = CGPoint(x: 0, y: 0)
    open var buttonGradientEndPoint = CGPoint(x: 0, y: 0)
    open var borderColor = UIColor.clear
    open var borderWidth = CGFloat(0)
    open var tintColorEnabled = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0)
    open var tintColorDisabled = UIColor.gray
    open var cornerRadius: CGFloat = 0
    open var contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    open var indicatorStyle = UIActivityIndicatorView.Style.white
    open var imageRenderingMode = UIImage.RenderingMode.alwaysOriginal
    public init() {}
}
