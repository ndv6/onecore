//
//  WebViewCoordinator.swift
//  ONECore
//
//  Created by DENZA on 06/10/19.
//

import UIKit

open class WebViewCoordinator: Coordinator {
    public let controller: WebViewController
    public let presenter: NavigationController

    public init(presenter: NavigationController) {
        self.controller = WebViewController()
        self.presenter = presenter
    }

    open func start() {
        controller.delegate = self
        presenter.pushViewController(controller, animated: true)
    }
}

extension WebViewCoordinator: WebViewControllerDelegate {}
