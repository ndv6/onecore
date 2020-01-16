//
//  CompletionInput.swift
//  Alamofire
//
//  Created by ALDO LAZUARDI on 05/07/19.
//

import UIKit

open class CompletionInput: Button {
    public var key: String = DefaultValue.emptyString
    open var didChangeAction: InputDidChangeHandler?
    open var didValidationErrorAction: InputDidValidationError?
    open var didValidationSuccessAction: InputDidValidationSuccess?
    private var sender: CompletionInputTableViewCell = CompletionInputTableViewCell()
    open func didChangeHandler(_ completionInput: CompletionInput) {}
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

    open func setup(
        name: String,
        sender: CompletionInputTableViewCell,
        didChangeAction: @escaping InputDidChangeHandler = { _, _  in }
    ) {
        self.name = name
        self.sender = sender
        self.didChangeAction = didChangeAction
    }
}

extension CompletionInput: InputProtocol {
    open func getInputView() -> UIView {
        return self
    }

    open func getValue() -> AnyObject {
        return sender.getStatusComplete() as AnyObject
    }

    open func getText() -> String {
        return sender.getStatusComplete() ? sender.className : DefaultValue.emptyString
    }

    open func resetValue() { }

    open func isEmpty() -> Bool {
        return getText() == DefaultValue.emptyString
    }

    public func getTag() -> Int {
        return tag
    }
}
