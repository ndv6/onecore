//
//  AppDelegate.swift
//  ONECore
//
//  Created by fradenza on 01/14/2020.
//  Copyright (c) 2020 fradenza. All rights reserved.
//

import UIKit
import ONECore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var rootCoordinator: RootCoordinator?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
    ) -> Bool {
        CoreManager.instance.setup()
        initHelper()
        startRootCoordinator()
        return true
    }

    private func initHelper() {
        SizeHelper.calculateScreenSize()
        SizeHelper.calculateWindowSize(navigationController: nil, tabBarController: nil)
    }

    func startRootCoordinator() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        rootCoordinator = RootCoordinator(window: window)
        rootCoordinator?.start()
    }
}
