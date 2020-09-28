//
//  AmountInputType.swift
//  ONECore
//
//  Created by Sofyan Fradenza Adi on 26/12/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

open class AmountInputType: InputType {
    private var textField: TextField = TextField()
    private let maxLength: Int = 18
    open var identifier: InputTypeIdentifier = .amount
    open func didBeginEditingHandler(_ textField: TextField) {}
    open func didEndEditingHandler(_ textField: TextField) {}
    open func resetValue() {}
    open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return true
    }

    public init(textField: TextField, defaultValue: Int? = nil) {
        self.textField = textField
        guard let defaultValue = defaultValue else { return }
        self.textField.text = String(defaultValue).withThousandSeparator()
    }

    open func render() {
        let icon = textField.isEmpty()
            ? CoreStyle.Image.currencyIDRInactive
            : CoreStyle.Image.currencyIDRActive
        textField.setLeftIcon(icon)
        textField.maxLength = maxLength
    }

    open func didChangeHandler(_ textField: TextField) {
        render()
        textField.text = textField.getText().withThousandSeparator()
    }

    open func getValue() -> AnyObject {
        guard let text = textField.text else { return 0 as AnyObject }
        return (Int(text.digits) ?? 0) as AnyObject
    }

    open func getOriginalText() -> String {
        return textField.text?.digits ?? DefaultValue.emptyString
    }

    open func getDisplayText() -> String {
        if let amount = getValue() as? Double {
            return amount.toCurrencyIDR()
        }
        return textField.getText()
    }

    open func shouldChangeCharactersIn(range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}
