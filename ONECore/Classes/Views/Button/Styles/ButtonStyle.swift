//
//  ButtonStyle.swift
//  ONECore
//
//  Created by DENZA on 06/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

@objc public protocol ButtonStyle {
    var textFont: UIFont { get }
    var textColorEnabled: UIColor { get }
    var textColorDisabled: UIColor { get }
    var textAlignment: NSTextAlignment { get }
    var buttonColorEnabled: UIColor { get }
    var buttonColorDisabled: UIColor { get }
    var buttonGradientColorsEnabled: [UIColor] { get }
    var buttonGradientColorsDisabled: [UIColor] { get }
    var buttonGradientStartPoint: CGPoint { get }
    var buttonGradientEndPoint: CGPoint { get }
    var borderColor: UIColor { get }
    var borderWidth: CGFloat { get }
    var tintColorEnabled: UIColor { get }
    var tintColorDisabled: UIColor { get }
    var cornerRadius: CGFloat { get }
    var contentEdgeInsets: UIEdgeInsets { get }
    var indicatorStyle: UIActivityIndicatorView.Style { get }
    var imageRenderingMode: UIImage.RenderingMode { get }
}
