//
//  TabBarNavigationController.swift
//  ONECore
//
//  Created by DENZA on 12/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

open class TabBarNavigationController: UITabBarController {
    open var navigationControllers: [NavigationController] {
        return [NavigationController]()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public init(tintColor: UIColor, backgroundColor: UIColor) {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = navigationControllers
        UITabBar.appearance().tintColor = tintColor
        UITabBar.appearance().barTintColor = backgroundColor
        UITabBar.appearance().backgroundColor = backgroundColor
    }

    public func getFirstNavigationController() -> NavigationController {
        guard let viewControllers = viewControllers else { return NavigationController() }
        guard let navigationController = viewControllers.first as? NavigationController else {
            return NavigationController()
        }
        return navigationController
    }

    public func moveToFirstPage() {
        selectedIndex = 0
    }

    public func moveToController(_ destinationClass: AnyClass) -> ViewController? {
        guard let controllers = self.viewControllers else { return nil }
        if controllers.isEmpty { return nil}
        for index in 0...(controllers.count - 1) {
            guard let nvc = controllers[index] as? NavigationController else { continue }
            guard let viewController = nvc.viewControllers.first as? ViewController else { continue }
            if viewController.isMember(of: destinationClass.self) {
                selectedIndex = index
                return viewController
            }
        }
        return nil
    }
}
