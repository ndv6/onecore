//
//  UITabBarController+Extension.swift
//  ONECore
//
//  Created by DENZA on 07/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

extension UITabBarController {
    public func setTabBarVisible(visible: Bool, animated: Bool) {
        if tabBarIsVisible() == visible { return }
        let frame = self.tabBar.frame
        let height = frame.size.height
        let offsetY = (visible ? -height : height)
        UIView.animate(withDuration: animated ? 0.3 : 0.0) {
            self.tabBar.frame = frame.offsetBy(dx: 0, dy: offsetY)
        }
    }

    public func tabBarIsVisible() -> Bool {
        return self.tabBar.frame.origin.y < self.view.frame.maxY
    }
}
