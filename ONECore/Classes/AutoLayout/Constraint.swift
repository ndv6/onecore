//
//  Constraint.swift
//  ONECore
//
//  Created by DENZA on 07/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

open class Constraint {
    public var leading: NSLayoutConstraint = NSLayoutConstraint()
    public var trailing: NSLayoutConstraint = NSLayoutConstraint()
    public var top: NSLayoutConstraint = NSLayoutConstraint()
    public var bottom: NSLayoutConstraint = NSLayoutConstraint()

    public init() {}

    public init(
        parentView: UIView,
        childView: UIView,
        leading: CGFloat = 0,
        trailing: CGFloat = 0,
        top: CGFloat = 0,
        bottom: CGFloat = 0
    ) {
        self.leading = NSLayoutConstraint(item: childView, attribute: .leading, relatedBy: .equal, toItem: parentView, attribute: .leading, multiplier: 1, constant: leading)
        self.trailing = NSLayoutConstraint(item: parentView, attribute: .trailing, relatedBy: .equal, toItem: childView, attribute: .trailing, multiplier: 1, constant: trailing)
        self.top = NSLayoutConstraint(item: childView, attribute: .top, relatedBy: .equal, toItem: parentView, attribute: .top, multiplier: 1, constant: top)
        self.bottom = NSLayoutConstraint(item: parentView, attribute: .bottom, relatedBy: .equal, toItem: childView, attribute: .bottom, multiplier: 1, constant: bottom)
    }

    public func activate() {
        NSLayoutConstraint.activate([leading, trailing, top, bottom])
    }
}
