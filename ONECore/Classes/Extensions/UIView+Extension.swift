//
//  UIView+Extension.swift
//  ONECore
//
//  Created by DENZA on 12/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

extension UIView {
    @objc public func setRoundedCorners(radius: CGFloat = 0) {
        applyRoundedCorners(radius: radius)
    }

    @objc public func applyCircleStyle() {
        applyRoundedCorners(radius: self.frame.size.height / 2)
    }

    public func applyRoundedTopCorners() {
        applyRoundedCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
    }

    public func applyRoundedBottomCorners() {
        applyRoundedCorners(corners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
    }

    public func applyRoundedCorners(radius: CGFloat = 10, corners: CACornerMask = [
        .layerMinXMinYCorner,
        .layerMaxXMinYCorner,
        .layerMinXMaxYCorner,
        .layerMaxXMaxYCorner
    ]) {
        clipsToBounds = true
        layer.cornerRadius = radius
        if #available(iOS 11.0, *) {
            layer.maskedCorners = corners
        }
    }

    public func removeRoundedCorners() {
        layer.cornerRadius = 0
    }

    public func applyBorder(color: UIColor, width: CGFloat = CGFloat(1)) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }

    public func getParentCell() -> TableViewCell? {
        var superview = self.superview
        while superview != nil {
            guard let view = superview else { return nil }
            if view.isKind(of: TableViewCell.self) {
                return view as? TableViewCell
            }
            superview = superview?.superview
        }
        return nil
    }

    public func removeAllSubviews() {
        for view in subviews {
            view.removeFromSuperview()
        }
    }

    public func applyDashedBorderLine() {
        let lineDashPattern: [NSNumber] = [4, 4]
        let lineDashWidth: CGFloat = 1.0
        let path = CGMutablePath()
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = lineDashWidth
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.lineDashPattern = lineDashPattern
        path.addLines(between: [CGPoint(x: bounds.minX, y: bounds.height/2),
                                CGPoint(x: bounds.width, y: bounds.height/2)])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }

    @discardableResult
    public func addBorders(
        edges: UIRectEdge,
        color: UIColor,
        inset: CGFloat = 0.0,
        thickness: CGFloat = 1.0
    ) -> [UIView] {
        var borders = [UIView]()
        @discardableResult
        func addBorder(formats: String...) -> UIView {
            let border = UIView(frame: .zero)
            border.backgroundColor = color
            border.translatesAutoresizingMaskIntoConstraints = false
            addSubview(border)
            addConstraints(formats.flatMap {
                NSLayoutConstraint.constraints(withVisualFormat: $0,
                                               options: [],
                                               metrics: ["inset": inset, "thickness": thickness],
                                               views: ["border": border])
            })
            borders.append(border)
            return border
        }
        if edges.contains(.top) || edges.contains(.all) {
            addBorder(formats: "V:|-0-[border(==thickness)]", "H:|-inset-[border]-inset-|")
        }
        if edges.contains(.bottom) || edges.contains(.all) {
            addBorder(formats: "V:[border(==thickness)]-0-|", "H:|-inset-[border]-inset-|")
        }
        if edges.contains(.left) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:|-0-[border(==thickness)]")
        }
        if edges.contains(.right) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:[border(==thickness)]-0-|")
        }
        return borders
    }

    internal func getFirstTextField() -> TextField? {
        var textField: TextField?
        for subview in subviews {
            if let subview = subview as? TextField {
                return subview
            }
            textField = subview.getFirstTextField()
            if textField != nil { return textField }
        }
        return textField
    }

    private static let kRotationAnimationKey = "rotationanimationkey"

    public func rotate(duration: Double = 1) {
        if layer.animation(forKey: UIView.kRotationAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Float.pi * 2.0
            rotationAnimation.duration = duration
            rotationAnimation.repeatCount = Float.infinity
            layer.add(rotationAnimation, forKey: UIView.kRotationAnimationKey)
        }
    }

    public func stopRotating() {
        if layer.animation(forKey: UIView.kRotationAnimationKey) != nil {
            layer.removeAnimation(forKey: UIView.kRotationAnimationKey)
        }
    }
    
    public func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
