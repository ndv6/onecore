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

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let tf: TextField = textField as? TextField else { return true }
        guard let initialText: String = tf.text else { return true }
        let isValidLength = tf.maxLength == 0 || initialText.count + string.count - range.length <= tf.maxLength
        var result = isValidLength && tf.shouldChangeCharactersIn(range: range, replacementString: string)
        if !result && string.isBackspace() { return true }
        if !result { return false }
        var replacementString = string
        if tf.autocapitalizationType == .allCharacters {
            replacementString = replacementString.uppercased()
            result = false
        }
        if tf.isAvoidWhitespaces {
            replacementString = replacementString.removeAllWhitespaces()
            result = false
        }
        if tf.keyboardType == .numberPad {
            replacementString = replacementString.digits
            result = false
        }
        if let allowedCharacters = tf.allowedCharacters {
            replacementString = replacementString.filterAllowedCharacters(allowedCharacters)
            result = false
        }
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
            tf.text = updatedText
        }
        if result || initialText != tf.text {
            tf.didChange(textField: tf, newValue: updatedText)
        }
        if let cursorLocation = cursorLocation {
            tf.selectedTextRange = tf.textRange(from: cursorLocation, to: cursorLocation)
        }
        return result
    }

    private func getUpdatedText(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> String {
        if let text = textField.text, let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(
                in: textRange,
                with: string
            )
            return updatedText
        }
        return DefaultValue.emptyString
    }
}
