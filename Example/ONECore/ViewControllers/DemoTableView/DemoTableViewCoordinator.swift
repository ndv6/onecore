//
//  DemoTableViewCoordinator.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 04/03/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import ONECore

class DemoTableViewCoordinator: Coordinator {
    private var presenter: NavigationController
    private let controller: DemoTableViewViewController
    private var alertCoordinator: AlertCoordinator?

    init(presenter: NavigationController) {
        self.presenter = presenter
        self.controller = DemoTableViewViewController()
        self.controller.title = R.string.localizable.menuTitleTableView()
    }

    func start() {
        controller.delegate = self
        presenter.pushViewController(controller, animated: true)
    }
}

extension DemoTableViewCoordinator: DemoTableViewViewControllerDelegate {
    func demoTableViewViewControllerDidReceivedError(error: ErrorResponse) {
        alertCoordinator = AlertCoordinator(
            presenter: presenter,
            title: error.code,
            message: error.message
        )
        alertCoordinator?.start()
    }
    
    func demoTableViewViewControllerDidSelectedFood(food: Food) {
        alertCoordinator = AlertCoordinator(presenter: presenter, message: food.title)
        alertCoordinator?.start()
    }
}
