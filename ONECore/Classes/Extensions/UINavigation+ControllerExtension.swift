//
//  UINavigationController+Extension.swift
//  ONECore
//
//  Created by DENZA on 12/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

extension UINavigationController {
    public func applyTransparentStyle() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        view.backgroundColor = .clear
    }

    public func setNavigationBarColor(_ color: UIColor) {
        navigationBar.shadowImage = UIImage()
        navigationBar.barTintColor = color
        navigationBar.isTranslucent = false
    }

    public func addNavigationShadow(
        shadowOffset: CGSize = CGSize(width: 0, height: 3.0),
        shadowColor: UIColor = UIColor.black.withAlphaComponent(0.1),
        shadowRadius: CGFloat = 5,
        shadowOppacity: Float = 1
    ) {
        navigationBar.layer.shadowColor = shadowColor.cgColor
        navigationBar.layer.shadowOffset = shadowOffset
        navigationBar.layer.shadowRadius = shadowRadius
        navigationBar.layer.shadowOpacity = shadowOppacity
    }
    
    public func hideNavigationShadow() {
        navigationBar.layer.shadowOffset = CGSize(width: 0, height: 0.0)
        navigationBar.layer.shadowRadius = 0
        navigationBar.layer.shadowOpacity = 0
        navigationBar.layer.shadowColor = UIColor.clear.cgColor
    }
}
