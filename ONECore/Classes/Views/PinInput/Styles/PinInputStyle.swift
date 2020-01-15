//
//  PinInputStyle.swift
//  ONECore
//
//  Created by DENZA on 21/09/19.
//

import UIKit

@objc public protocol PinInputStyle {
    var font: UIFont { get }
    var textColor: UIColor { get }
    var backgroundColor: UIColor { get }
    var borderColor: UIColor { get }
    var borderWidth: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var bottomLineColor: UIColor { get }
    var bottomLineWidth: CGFloat { get }
}
