//
//  FreeTextInputType.swift
//  ONECore
//
//  Created by DENZA on 23/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

open class FreeTextInputType: InputType {
    private var textField: TextField = TextField()
    open var identifier: InputTypeIdentifier = .freetext
    public func render() {}
    public func didBeginEditingHandler(_ textField: TextField) {}
    public func didEndEditingHandler(_ textField: TextField) {}
    public func didChangeHandler(_ textField: TextField) {}
    public func resetValue() {}
    open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return true
    }

    public init(textField: TextField) {
        self.textField = textField
    }

    public func getValue() -> AnyObject {
        return textField.getText() as AnyObject
    }

    open func getOriginalText() -> String {
        return textField.text ?? DefaultValue.emptyString
    }

    public func getDisplayText() -> String {
        return textField.getText()
    }

    open func shouldChangeCharactersIn(range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}
