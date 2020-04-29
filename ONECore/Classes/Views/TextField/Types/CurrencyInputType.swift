//
//  CurrencyInputType.swift
//  ONECore
//
//  Created by Sofyan Fradenza Adi on 28/04/20.
//

import UIKit

open class CurrencyInputType: InputType {
    private var textField: TextField
    private var prefix: String
    open var identifier: InputTypeIdentifier = .currency
    open func render() {}
    open func resetValue() {}
    open func didBeginEditingHandler(_ textField: TextField) {}
    open func didEndEditingHandler(_ textField: TextField) {}

    public init(textField: TextField, prefix: String, defaultValue: Double? = nil) {
        self.textField = textField
        self.textField.keyboardType = .numberPad
        self.prefix = prefix
        self.textField.text = getDisplayText(
            originalText: defaultValue?.clean ?? DefaultValue.emptyString
        )
    }

    open func getValue() -> AnyObject {
        guard let text = textField.text else { return DefaultValue.emptyDouble as AnyObject }
        return text.digits.doubleValue as AnyObject
    }

    open func getOriginalText() -> String {
        return textField.text?.removePrefix(prefix) ?? DefaultValue.emptyString
    }

    open func getDisplayText() -> String {
        return getDisplayText(originalText: textField.getText())
    }

    open func shouldChangeCharactersIn(range: NSRange, replacementString string: String) -> Bool {
        let currentTextLength = textField.text?.count ?? DefaultValue.emptyInt
        if range.location < prefix.count { return false }
        if range.location == prefix.count && string == String(DefaultValue.emptyInt) {
            return false
        }
        if textField.text == prefix && string == DefaultValue.emptyString {
            return false
        }
        if range.location == currentTextLength - 1 && string.isBackspace() {
            return true
        } else if range.location < currentTextLength {
            return false
        }
        return true
    }

    open func didChangeHandler(_ textField: TextField) {
        textField.text = getDisplayText()
    }

    open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return action != #selector(UIResponderStandardEditActions.paste(_:))
    }

    private func getDisplayText(originalText: String) -> String {
        return String(format: "%@%@", prefix, originalText.withThousandSeparator())
    }
}
