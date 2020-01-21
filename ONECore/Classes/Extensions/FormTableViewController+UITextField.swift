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
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        guard let txtField: TextField = textField as? TextField else { return true }
        guard let initialText: String = txtField.text else { return true }
        let isValidLength = txtField.maxLength == 0
            || initialText.count + string.count - range.length <= txtField.maxLength
        var result = isValidLength && txtField.shouldChangeCharactersIn(range: range, replacementString: string)
=======
=======
>>>>>>> fix 100 warnings
        shouldChangeCharactersIn
        range: NSRange,
        replacementString string: String
    ) -> Bool {
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> fix 100 warnings
        guard let tf: TextField = textField as? TextField else { return true }
        guard let initialText: String = tf.text else { return true }
        let isValidLength = tf.maxLength == 0 || initialText.count + string.count - range.length <= tf.maxLength
        var result = isValidLength && tf.shouldChangeCharactersIn(range: range, replacementString: string)
>>>>>>> fix 100 warnings
        if !result && string.isBackspace() { return true }
        if !result { return false }
        let replacementString = composeReplacementStringFrom(string, textfield: txtField)
        result = !isNeedToOverrideText(textfield: txtField)
=======
        guard let coreTextField: TextField = textField as? TextField else { return true }
        guard let initialText: String = coreTextField.text else { return true }
        let isValidLength = coreTextField.maxLength == 0
            || initialText.count + string.count - range.length <= coreTextField.maxLength
        var result = isValidLength && coreTextField.shouldChangeCharactersIn(
            range: range,
            replacementString: string
        )
        if !result && string.isBackspace() { return true }
        if !result { return false }
        let replacementString = composeReplacementStringFrom(string, textfield: coreTextField)
        result = isNeedToOverrideText(textfield: coreTextField)
>>>>>>> fix 70 warnings
=======
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
=======
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
>>>>>>> revert code
        guard let txtField: TextField = textField as? TextField else { return true }
        guard let initialText: String = txtField.text else { return true }
        let isValidLength = txtField.maxLength == 0
            || initialText.count + string.count - range.length <= txtField.maxLength
        var result = isValidLength && txtField.shouldChangeCharactersIn(range: range, replacementString: string)
<<<<<<< HEAD
        if !result && string.isBackspace() { return true }
        if !result { return false }
<<<<<<< HEAD
<<<<<<< HEAD
        var replacementString = string
        if txtField.autocapitalizationType == .allCharacters {
            replacementString = replacementString.uppercased()
            result = false
        }
        if txtField.isAvoidWhitespaces {
            replacementString = replacementString.removeAllWhitespaces()
            result = false
        }
        if txtField.keyboardType == .numberPad {
            replacementString = replacementString.digits
            result = false
        }
        if let allowedCharacters = txtField.allowedCharacters {
            replacementString = replacementString.filterAllowedCharacters(allowedCharacters)
            result = false
        }
>>>>>>> revert code
=======
        var replacementString = composeReplacementStringFrom(string, textfield: txtField)
=======
        let replacementString = composeReplacementStringFrom(string, textfield: txtField)
>>>>>>> fix let variable
        result = !isNeedToOverrideText(textfield: txtField)
>>>>>>> fix replacement string
=======
        guard let coreTextField: TextField = textField as? TextField else { return true }
        guard let initialText: String = coreTextField.text else { return true }
        let isValidLength = coreTextField.maxLength == 0
            || initialText.count + string.count - range.length <= coreTextField.maxLength
        var result = isValidLength && coreTextField.shouldChangeCharactersIn(
            range: range,
            replacementString: string
        )
        if !result && string.isBackspace() { return true }
        if !result { return false }
<<<<<<< HEAD
        let replacementString = composeReplacementStringFrom(string, textfield: coreTextField)
        result = isNeedToOverrideText(textfield: coreTextField)
>>>>>>> fix 70 warnings
=======
        if !result && string.isBackspace() { return true }
        if !result { return false }
<<<<<<< HEAD
        var replacementString = string
        if txtField.autocapitalizationType == .allCharacters {
            replacementString = replacementString.uppercased()
            result = false
        }
        if txtField.isAvoidWhitespaces {
            replacementString = replacementString.removeAllWhitespaces()
            result = false
        }
        if txtField.keyboardType == .numberPad {
            replacementString = replacementString.digits
            result = false
        }
        if let allowedCharacters = txtField.allowedCharacters {
            replacementString = replacementString.filterAllowedCharacters(allowedCharacters)
            result = false
        }
>>>>>>> revert code
=======
        var replacementString = composeReplacementStringFrom(string, textfield: txtField)
=======
        let replacementString = composeReplacementStringFrom(string, textfield: txtField)
>>>>>>> fix let variable
        result = !isNeedToOverrideText(textfield: txtField)
>>>>>>> fix replacement string
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
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
            txtField.text = updatedText
        }
        if result || initialText != txtField.text {
            txtField.didChange(textField: txtField, newValue: updatedText)
        }
        if let cursorLocation = cursorLocation {
            txtField.selectedTextRange = txtField.textRange(from: cursorLocation, to: cursorLocation)
=======
            coreTextField.text = updatedText
=======
            txtField.text = updatedText
>>>>>>> revert code
        }
        if result || initialText != txtField.text {
            txtField.didChange(textField: txtField, newValue: updatedText)
        }
        if let cursorLocation = cursorLocation {
<<<<<<< HEAD
            coreTextField.selectedTextRange = coreTextField.textRange(from: cursorLocation, to: cursorLocation)
>>>>>>> fix 70 warnings
=======
            txtField.selectedTextRange = txtField.textRange(from: cursorLocation, to: cursorLocation)
>>>>>>> revert code
=======
            coreTextField.text = updatedText
=======
            txtField.text = updatedText
>>>>>>> revert code
        }
        if result || initialText != txtField.text {
            txtField.didChange(textField: txtField, newValue: updatedText)
        }
        if let cursorLocation = cursorLocation {
<<<<<<< HEAD
            coreTextField.selectedTextRange = coreTextField.textRange(from: cursorLocation, to: cursorLocation)
>>>>>>> fix 70 warnings
=======
            txtField.selectedTextRange = txtField.textRange(from: cursorLocation, to: cursorLocation)
>>>>>>> revert code
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
