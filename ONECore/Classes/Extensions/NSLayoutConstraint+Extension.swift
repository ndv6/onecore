//
//  NSLayoutConstraint+Extension.swift
//  ONECore
//
//  Created by Sofyan Fradenza Adi on 29/10/19.
//

import UIKit

extension NSLayoutConstraint {
    public func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        guard let firstItem = firstItem else { return self }
        return NSLayoutConstraint(
            item: firstItem,
            attribute: self.firstAttribute,
            relatedBy: self.relation,
            toItem: self.secondItem,
            attribute: self.secondAttribute,
            multiplier: multiplier,
            constant: self.constant
        )
    }
}
