//
//  MainMenuCoordinator.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 23/12/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import ONECore

class MainMenuCoordinator: Coordinator {
    private let sender: UIViewController
    private var presenter: NavigationController
    private let controller: MainMenuViewController
    private var demoCollectionCoordinator: DemoCollectionCoordinator?

    init(sender: UIViewController) {
        self.sender = sender
        self.controller = MainMenuViewController()
        self.presenter = NavigationController(rootViewController: controller)
    }

    func start() {
        controller.delegate = self
        sender.presentInFullScreen(presenter, animated: true, completion: nil)
    }
}

extension MainMenuCoordinator: MainMenuViewControllerDelegate {
    func mainMenuViewControllerDidSelectMenu(_ menu: MenuItemViewModel) {
        menu.destinationCoordinator?.start()
    }

    func mainMenuViewControllerWillAppear() {
        setupMainMenus()
    }
}

extension MainMenuCoordinator {
    private func setupMainMenus() {
        controller.menus.removeAll()
        registerDemoCameraCoordinator()
        registerDemoCollectionCoordinator()
        registerDemoPinInputCoordinator()
    }

    private func registerDemoCameraCoordinator() {
        controller.menus.append(MenuItemViewModel(
            title: R.string.localizable.menuTitleCameraViewController(),
            destinationCoordinator: nil //#todo
        ))
    }

    private func registerDemoCollectionCoordinator() {
        demoCollectionCoordinator = DemoCollectionCoordinator(presenter: presenter)
        controller.menus.append(MenuItemViewModel(
            title: R.string.localizable.menuTitleCollectionView(),
            destinationCoordinator: demoCollectionCoordinator
        ))
    }

    private func registerDemoPinInputCoordinator() {
        controller.menus.append(MenuItemViewModel(
            title: R.string.localizable.menuTitlePinInputView(),
            destinationCoordinator: nil //#todo
        ))
    }
}
