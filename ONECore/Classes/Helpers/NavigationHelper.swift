//
//  NavigationHelper.swift
//  ONECore
//
//  Created by DENZA on 22/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

public class NavigationHelper {
    public static func getCurrentViewController() -> UIViewController? {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }

    public static func resetToRootVC(sender: ViewController) {
        guard let window = sender.view.window else { return }
        guard let rootViewController = window.rootViewController else { return }
        rootViewController.dismiss(animated: true, completion: nil)
    }

    public static func createTabBarItemNavigationController(
        title: String,
        icon: UIImage,
        font: UIFont,
        selectedIcon: UIImage?,
        vc: UIViewController
    ) -> NavigationController {
        let nvc = NavigationController(rootViewController: vc)
        nvc.tabBarItem.title = title
        nvc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        nvc.tabBarItem.image = icon
        if let selectedIcon = selectedIcon {
            nvc.tabBarItem.selectedImage = selectedIcon
        }
        return nvc
    }

    public static func openAppSettings() {
        guard let url = NSURL(string: UIApplication.openSettingsURLString) as URL? else { return }
        UIApplication.shared.openURL(url)
    }
}
