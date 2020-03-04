//
//  TextFieldCell+Setter.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 04/03/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import ONECore

extension TextFieldCell {
    func setPaddingTop(_ margin: CGFloat) {
        containerTop.constant = margin
    }

    func setPaddingBottom(_ margin: CGFloat) {
        containerBottom.constant = margin
    }

    func setMarginLeft(_ margin: CGFloat) {
        containerLeading.constant = margin
    }

    func setMarginRight(_ margin: CGFloat) {
        containerTrailing.constant = margin
    }

    func setTitle(_ title: String) {
        let attribute = NSMutableAttributedString(string: title)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2.5
        attribute.addAttribute(
            NSAttributedString.Key.paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attribute.length)
        )
        titleLabel.attributedText = attribute
        textField.name = title
        setAccessibilityIdentifier(title)
        constraintContainerTop.constant = title.isEmpty
            ? DefaultValue.emptyCGFloat
            : SpaceSize.mediumSmall
    }

    func setPlaceholder(_ placeholder: String) {
        textField.placeholder = placeholder
    }

    func setTextFieldDelegate(_ delegate: UITextFieldDelegate) {
        textField.delegate = delegate
    }

    func setTextFieldDidChangeAction(_ action: @escaping InputDidChangeHandler) {
        textField.didChangeAction = action
    }

    func setTextFieldKey(_ key: String) {
        textField.key = key
    }

    func setHint(_ hint: String) {
        hintMessage = hint
    }

    func setAccessibilityIdentifier(_ identifier: String) {
        titleLabel.accessibilityIdentifier = String(
            format: AccessibilityIdentifier.label,
            identifier.toAccessibilityFormat()
        )
        hintLabel.accessibilityIdentifier = String(
            format: AccessibilityIdentifier.hintLabel,
            identifier.toAccessibilityFormat()
        )
        errorLabel.accessibilityIdentifier = String(
            format: AccessibilityIdentifier.errorLabel,
            identifier.toAccessibilityFormat()
        )
        if textField.accessibilityIdentifier == nil {
            textField.accessibilityIdentifier = String(
                format: AccessibilityIdentifier.textfield,
                identifier.toAccessibilityFormat()
            )
        }
    }

    func setValidationRules(_ validationRules: [Rule]) {
        self.validationRules = validationRules
    }

    func setKeyboardType(_ keyboardType: UIKeyboardType) {
        textField.keyboardType = keyboardType
    }

    func setReturnKey(_ keyType: UIReturnKeyType) {
        textField.returnKeyType = keyType
    }

    func setMaxLength(_ maxLength: Int) {
        textField.maxLength = maxLength
    }

    func setRightIcon(_ icon: UIImage) {
        textField.setRightButton(icon: icon)
    }

    func removeRightIcon() {
        textField.removeRightButton()
    }

    func setMicroButton(
        title: String,
        isEnabled: Bool = true,
        style: ButtonStyle = PrimaryButtonStyle(),
        action: @escaping PressButtonHandler = {}
    ) {
        microButton.setTitle(title, for: .normal)
        microButton.didPressAction = action
        microButton.isHidden = false
        setMicroButton(isEnabled: isEnabled)
    }

    func setMicroButton(isEnabled: Bool) {
        microButton.isEnabled = isEnabled
    }

    func setMicroButton(isHidden: Bool) {
        microButton.isHidden = isHidden
    }

    func setAlwaysCapital(_ isAlwaysCapital: Bool = true) {
        textField.autocapitalizationType = isAlwaysCapital ? .allCharacters : .none
    }

    func setAllowedCharacters(_ allowedCharacters: String) {
        textField.allowedCharacters = allowedCharacters
    }

    func setAvoidWhitespaces(_ isAvoidWhitespaces: Bool = true) {
        textField.isAvoidWhitespaces = isAvoidWhitespaces
    }

    func setValue(_ text: String) {
        guard let textfield = textField else { return }
        textfield.text = text
    }

    func setTextFieldRightButton(icon: UIImage, action: @escaping PressButtonHandler) {
        textField.setRightButton(icon: icon, action: action)
    }
}
