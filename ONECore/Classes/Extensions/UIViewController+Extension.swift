//
//  UIViewController+Extension.swift
//  Alamofire
//
//  Created by NICKO PRASETIO on 16/12/19.
//

import Foundation

extension UIViewController {
    open func presentInFullScreen(
        _ viewController: UIViewController,
        animated: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: animated, completion: completion)
    }
}
