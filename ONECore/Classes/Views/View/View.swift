//
//  View.swift
//  ONECore
//
//  Created by DENZA on 06/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

open class View: UIView {
    private var parentConstraint: Constraint!
    private var gradientLayer: CAGradientLayer = CAGradientLayer()
    private var shadowLayer: CAShapeLayer = CAShapeLayer()
    private var shadowLayerCornerRadius: CGFloat = 0
    private let gradientLayerIdentifier = "GradientLayerIdentifier"

    public func resetParentConstraint(parentView: UIView) {
        if parentConstraint != nil {
            parentView.removeConstraint(parentConstraint.leading)
            parentView.removeConstraint(parentConstraint.trailing)
            parentView.removeConstraint(parentConstraint.top)
            parentView.removeConstraint(parentConstraint.bottom)
        }
    }

    public func setParentConstraint(parentView: UIView) {
        setParentConstraint(parentView: parentView, bottom: 0)
    }

    public func setParentConstraint(parentView: UIView, bottom: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        resetParentConstraint(parentView: parentView)
        if !self.isDescendant(of: parentView) {
            parentView.addSubview(self)
        }
        parentConstraint = Constraint(parentView: parentView, childView: self)
        parentConstraint.bottom.constant = bottom
        parentView.addConstraint(parentConstraint.leading)
        parentView.addConstraint(parentConstraint.trailing)
        parentView.addConstraint(parentConstraint.top)
        parentView.addConstraint(parentConstraint.bottom)
        parentConstraint.activate()
    }

    public func setGradientColors(
        _ colors: [UIColor],
        startPoint: CGPoint = CGPoint(x: 0, y: 0),
        endPoint: CGPoint = CGPoint(x: 1, y: 1)
    ) {
        var cgColors = [CGColor]()
        for color in colors { cgColors.append(color.cgColor) }
        backgroundColor = UIColor.clear
        gradientLayer = CAGradientLayer()
        gradientLayer.name = gradientLayerIdentifier
        gradientLayer.frame = bounds
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.colors = cgColors
        if gradientLayer.superlayer == nil { layer.insertSublayer(gradientLayer, at: 0) }
        if shadowLayer.superlayer != nil { shadowLayer.removeFromSuperlayer() }
    }

    public func removeGradientColors() {
        layer.sublayers?.removeAll(where: {$0.name == gradientLayerIdentifier})
    }

    public func setDropShadow(
        fillColor: UIColor,
        cornerRadius: CGFloat = 0,
        shadowRadius: CGFloat = 0,
        shadowOpacity: CGFloat = 0.2,
        shadowOffset: CGSize = CGSize(width: 0.0, height: 1.0),
        shadowColor: UIColor = UIColor.black
    ) {
        shadowLayer.removeFromSuperlayer()
        shadowLayerCornerRadius = cornerRadius
        backgroundColor = UIColor.clear
        shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        shadowLayer.fillColor = fillColor.cgColor
        shadowLayer.shadowColor = shadowColor.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = shadowOffset
        shadowLayer.shadowOpacity = Float(shadowOpacity)
        shadowLayer.shadowRadius = shadowRadius
        if shadowLayer.superlayer == nil { layer.insertSublayer(shadowLayer, at: 0) }
        if gradientLayer.superlayer != nil { gradientLayer.removeFromSuperlayer() }
    }

    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        if gradientLayer.superlayer != nil {
            gradientLayer.frame = bounds
        }
        if shadowLayer.superlayer != nil {
            shadowLayer.path = UIBezierPath(
                roundedRect: bounds,
                cornerRadius: shadowLayerCornerRadius
            ).cgPath
            shadowLayer.shadowPath = shadowLayer.path
        }
    }
}
