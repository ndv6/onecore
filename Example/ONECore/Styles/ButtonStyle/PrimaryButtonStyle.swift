//
//  PrimaryButtonStyle.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 04/03/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import ONECore

class PrimaryButtonStyle: ButtonStyle {
    public var textFont = UIFont.systemFont(ofSize: FontSize.paragraph2, weight: .regular)
    public var textColorEnabled = Colors.white
    public var textColorDisabled = Colors.lightGray
    public var textAlignment = NSTextAlignment.center
    public var buttonColorEnabled = Colors.primary
    public var buttonColorDisabled = Colors.gray
    public var buttonGradientColorsEnabled = [Colors.primary]
    public var buttonGradientColorsDisabled = [Colors.gray]
    public var buttonGradientStartPoint = CGPoint(x: 0, y: 0)
    public var buttonGradientEndPoint = CGPoint(x: 1, y: 1)
    public var borderColor = UIColor.clear
    public var borderWidth = CGFloat(0)
    public var tintColorEnabled = UIColor.white
    public var tintColorDisabled = UIColor.white
    public var cornerRadius = SpaceSize.mediumSmall
    public var contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    public var indicatorStyle = UIActivityIndicatorView.Style.white
    public var imageRenderingMode = UIImage.RenderingMode.alwaysOriginal
}
