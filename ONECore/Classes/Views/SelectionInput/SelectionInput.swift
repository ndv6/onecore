//
//  SelectionInput.swift
//  Kelolala
//
//  Created by Sofyan Fradenza Adi on 20/05/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import UIKit

public typealias SelectionInputDidChangeHandler = (_ selectionInput: SelectionInput) -> Void

public protocol SelectionInputDelegate: class {
    func selectionInputDidEndEditing(_ selectionInput: SelectionInput)
}

open class SelectionInput: Button {
    public var key: String = DefaultValue.emptyString
    public weak var delegate: SelectionInputDelegate?
    open var didChangeAction: InputDidChangeHandler?
    open var didValidationErrorAction: InputDidValidationError?
    open var didValidationSuccessAction: InputDidValidationSuccess?
    private var controller: SelectionInputViewController = SelectionInputViewController()
    private var sender: ViewController = ViewController()
    open func didChangeHandler(_ selectionInput: SelectionInput) {}
    open var name: String = DefaultValue.emptyString {
        didSet {
            self.accessibilityIdentifier = String(
                format: AccessibilityIdentifier.button,
                name.toAccessibilityFormat()
            )
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    open func resetState() {}

    open func setup(
        name: String,
        sender: ViewController,
        controller: SelectionInputViewController,
        defaultValue: [Option]? = [Option](),
        didChangeAction: @escaping InputDidChangeHandler = {_,_  in }
    ) {
        self.name = name
        self.sender = sender
        self.controller = controller
        self.controller.screenTitle = self.name
        self.didChangeAction = didChangeAction
        self.didPressAction = {
            self.controller.didSelectAction = self.didSelectOptions
            self.sender.present(
                NavigationController(rootViewController: self.controller),
                animated: true,
                completion: nil
            )
        }
        if let defaultValue = defaultValue {
            self.controller.selectedOptions = defaultValue
            didSelectOptions(defaultValue)
        }
    }

    private func didSelectOptions(_ options: [Option]) {
        delegate?.selectionInputDidEndEditing(self)
        guard let didChangeAction = didChangeAction else { return }
        didChangeAction(self, getValue())
    }
}

extension SelectionInput: InputProtocol {
    open func getInputView() -> UIView {
        return self
    }

    open func getValue() -> AnyObject {
        return controller.selectedOptions as AnyObject
    }

    open func getText() -> String {
        return controller.selectedOptions.displayText()
    }

    open func resetValue() {
        controller.didLoadData = false
        controller.resetSelection()
    }

    open func isEmpty() -> Bool {
        return getText() == DefaultValue.emptyString
    }

    public func getTag() -> Int {
        return tag
    }
}
