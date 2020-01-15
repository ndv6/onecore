//
//  FreeTextInputType.swift
//  ONECore
//
//  Created by DENZA on 23/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

open class FreeTextInputType: InputType {
    public var identifier: InputTypeIdentifier = .freetext
    private var textField: TextField = TextField()
    public func render() {}
    public func didBeginEditingHandler(_ textField: TextField) {}
    public func didEndEditingHandler(_ textField: TextField) {}
    public func didChangeHandler(_ textField: TextField) {}
    public func resetValue() {}

    public init(textField: TextField) {
        self.textField = textField
    }

    public func getValue() -> AnyObject {
        return textField.getText() as AnyObject
    }

    public func getDisplayText() -> String {
        return textField.getText()
    }

    open func shouldChangeCharactersIn(range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}
