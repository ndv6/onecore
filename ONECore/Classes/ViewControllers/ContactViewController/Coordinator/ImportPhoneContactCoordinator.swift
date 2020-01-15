//
//  ImportPhoneContactCoordinator.swift
//  ONEOnboard
//
//  Created by Mac User on 15/10/19.
//

import UIKit
import ContactsUI

public typealias PhoneNumberSelectionHandler = (_ contactName: String, _ phone: String) -> Void

public class ImportPhoneContactCoordinator: ContactCoordinator {
    public var didSelectAction: PhoneNumberSelectionHandler?

    public convenience init(presenter: NavigationController, didSelectAction: PhoneNumberSelectionHandler?) {
        self.init(presenter: presenter)
        self.controller.displayedPropertyKeys = [CNContactPhoneNumbersKey]
        self.didSelectAction = didSelectAction
    }

    public override func contactPicker(_ picker: CNContactPickerViewController, didSelect contactProperty: CNContactProperty) {
        let contact = contactProperty.contact
        let contactName = CNContactFormatter.string(from: contact, style: .fullName) ?? DefaultValue.emptyString
        guard let phone = contactProperty.value as? CNPhoneNumber else { return }
        didSelectAction?(contactName, phone.stringValue)
    }
}
