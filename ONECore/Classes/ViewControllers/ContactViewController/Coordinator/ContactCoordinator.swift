//
//  ContactCoordinator.swift
//  ONECore
//
//  Created by Mac User on 14/10/19.
//

import UIKit
import ContactsUI

open class ContactCoordinator: NSObject, Coordinator, CNContactPickerDelegate {
    public var controller: ContactViewController
    public var presenter: NavigationController

    convenience override init() {
        self.init(presenter: NavigationController())
    }

    public init(presenter: NavigationController) {
        self.controller = ContactViewController()
        self.presenter = presenter
        super.init()
    }

    open func start() {
        controller.delegate = self
        presenter.present(controller, animated: true, completion: nil)
    }

    public func contactPicker(_ picker: CNContactPickerViewController, didSelect contactProperty: CNContactProperty) {}

    public func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
