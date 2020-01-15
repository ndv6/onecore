//
//  AlertCoordinator.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 14/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import ONECore

class AlertCoordinator: Coordinator {
    private var presenter: NavigationController
    private let controller: AlertController

    init(
        presenter: NavigationController,
        title: String = DefaultValue.emptyString,
        message: String = DefaultValue.emptyString
    ) {
        self.presenter = presenter
        self.controller = AlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertControllerStyle.alert
        )
        controller.addAction(UIAlertAction(
            title: R.string.localizable.buttonOk(),
            style: UIAlertActionStyle.cancel,
            handler: nil
        ))
    }

    func start() {
        presenter.present(controller, animated: true)
    }
}
