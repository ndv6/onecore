//
//  RootCoordinator.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 23/12/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import ONECore

class RootCoordinator: Coordinator {
    private let window: UIWindow
    private let controller: RootViewController
    private var mainMenuCoordinator: MainMenuCoordinator?

    init(window: UIWindow) {
        self.window = window
        self.controller = RootViewController()
    }

    func start() {
        controller.delegate = self
        window.rootViewController = controller
        window.makeKeyAndVisible()
    }
}

extension RootCoordinator: RootViewControllerDelegate {
    func rootViewControllerDidCompleted() {
        mainMenuCoordinator = MainMenuCoordinator(sender: controller)
        mainMenuCoordinator?.start()
    }
}
