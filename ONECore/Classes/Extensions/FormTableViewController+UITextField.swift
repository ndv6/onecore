//
//  FormTableViewController+UITextField.swift
//  ONECore
//
//  Created by DENZA on 09/03/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import UIKit

extension FormTableViewController: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let textField = textField as? TextField else { return }
        textField.didBeginEditingHandler(textField)
    }

    public func textFieldDidEndEditing(_ textField: UITextField) {
        guard let textField = textField as? TextField else { return }
        textField.didEndEditingHandler(textField)
        refreshErrorMessage()
    }

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == .send {
            validateForm()
            return true
        }
        if textField.returnKeyType == .next {
            guard let nextInput = getNextInput(currentInput: textField) as? UITextField else {
                textField.resignFirstResponder()
                return true
            }
            refreshErrorMessage()
            nextInput.becomeFirstResponder()
            return false
        }
        textField.resignFirstResponder()
        return true
    }

    public func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        guard let txtField: TextField = textField as? TextField else { return true }
        guard let initialText: String = txtField.text else { return true }
        let isValidLength = txtField.maxLength == 0
            || initialText.count + string.count - range.length <= txtField.maxLength
        var result = isValidLength && txtField.shouldChangeCharactersIn(range: range, replacementString: string)
        if !result && string.isBackspace() { return true }
        if !result { return false }
        var replacementString = composeReplacementStringFrom(string, textfield: txtField)
        result = !isNeedToOverrideText(textfield: txtField)
        let updatedText = getUpdatedText(
            textField,
            shouldChangeCharactersIn: range,
            replacementString: replacementString
        )
        let offsetValue = string.isBackspace() ? 1 : -1
        let cursorLocation = textField.position(
            from: textField.beginningOfDocument,
            offset: result ? range.lowerBound + string.count + offsetValue : range.lowerBound + string.count
        )
        if !result {
            txtField.text = updatedText
        }
        if result || initialText != txtField.text {
            txtField.didChange(textField: txtField, newValue: updatedText)
        }
        if let cursorLocation = cursorLocation {
            txtField.selectedTextRange = txtField.textRange(from: cursorLocation, to: cursorLocation)
        }
        return result
    }

    private func getUpdatedText(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> String {
        if let text = textField.text, let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(
                in: textRange,
                with: string
            )
            return updatedText
        }
        return DefaultValue.emptyString
    }

    private func composeReplacementStringFrom(_ text: String, textfield: TextField) -> String {
        var replacementString = text
        if textfield.autocapitalizationType == .allCharacters {
            replacementString = replacementString.uppercased()
        }
        if textfield.isAvoidWhitespaces {
            replacementString = replacementString.removeAllWhitespaces()
        }
        if textfield.keyboardType == .numberPad {
            replacementString = replacementString.digits
        }
        if let allowedCharacters = textfield.allowedCharacters {
            replacementString = replacementString.filterAllowedCharacters(allowedCharacters)
        }
        return replacementString
    }

    private func isNeedToOverrideText(textfield: TextField) -> Bool {
        return textfield.autocapitalizationType == .allCharacters
            || textfield.isAvoidWhitespaces
            || textfield.keyboardType == .numberPad
            || textfield.allowedCharacters != nil
    }
}
