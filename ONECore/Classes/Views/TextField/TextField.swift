//
//  TextField.swift
//  ONECore
//
//  Created by DENZA on 08/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

public typealias TextFieldDidChangeHandler = (_ textfield: TextField) -> Void

open class TextField: UITextField {
    private var inputType: InputType!
    private var leftIconContainerSize: CGFloat = 0
    private var rightIconContainerSize: CGFloat = 0
    private var rightButton: Button?
    internal var bottomLineLayer: CALayer = CALayer()
    open var didChangeAction: InputDidChangeHandler?
    open var didValidationErrorAction: InputDidValidationError?
    open var didValidationSuccessAction: InputDidValidationSuccess?
    public var key: String = DefaultValue.emptyString
    public var isAvoidWhitespaces: Bool = false
    public var maxLength: Int = 255
    public var allowedCharacters: String?
    public var style: TextFieldStyle = DefaultTextFieldStyle() {
        didSet {
            applyStyle()
        }
    }
    open var name: String = DefaultValue.emptyString {
        didSet {
            self.accessibilityIdentifier = String(
                format: AccessibilityIdentifier.textfield,
                name.toAccessibilityFormat()
            )
        }
    }

    override open func awakeFromNib() {
        super.awakeFromNib()
        inputType = FreeTextInputType(textField: self)
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: calculateContentPadding())
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: calculateContentPadding())
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: calculateContentPadding())
    }

    private func calculateContentPadding() -> UIEdgeInsets {
        var padding = style.padding
        if leftIconContainerSize != 0 {
            padding.left = leftIconContainerSize + 8
        }
        if rightIconContainerSize != 0 {
            padding.right = rightIconContainerSize
        }
        return padding
    }

    private func applyStyle() {
        font = style.font
        textColor = style.color
        attributedPlaceholder = NSAttributedString(
            string: placeholder ?? DefaultValue.emptyString,
            attributes: [NSAttributedString.Key.foregroundColor: style.placeholderColor]
        )
        backgroundColor = style.backgroundColor
        tintColor = style.tintColor
    }

    open func setLeftIcon(_ image: UIImage) {
        leftIconContainerSize = frame.size.height
        let verticalPadding = CGFloat(6)
        let leftPadding = CGFloat(12)
        let iconSize = leftIconContainerSize - (verticalPadding * 2)
        let iconView = UIImageView(frame: CGRect(x: leftPadding, y: verticalPadding, width: iconSize, height: iconSize))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: leftIconContainerSize,
            height: leftIconContainerSize
        ))
        iconContainerView.backgroundColor = .clear
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }

    open func setRightIcon(_ image: UIImage) {
        rightIconContainerSize = frame.size.height - 15
        let verticalPadding = CGFloat(5)
        let iconSize = rightIconContainerSize - (verticalPadding * 2)
        let iconView = UIImageView(frame: CGRect(x: 0, y: verticalPadding, width: iconSize, height: iconSize))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: rightIconContainerSize,
            height: rightIconContainerSize
        ))
        iconContainerView.backgroundColor = .clear
        iconContainerView.addSubview(iconView)
        rightView = iconContainerView
        rightViewMode = .always
    }

    open func setRightButton(
        icon: UIImage,
        style: ButtonStyle = DefaultButtonStyle(),
        action: @escaping () -> Void = {}
    ) {
        rightIconContainerSize = frame.size.height
        let button = Button(type: .custom)
        button.setImage(icon.withRenderingMode(style.imageRenderingMode), for: .normal)
        button.frame = CGRect(
            x: frame.size.width - rightIconContainerSize,
            y: 0,
            width: rightIconContainerSize,
            height: rightIconContainerSize
        )
        button.didPressAction = action
        button.style = style
        rightButton = button
        rightView = rightButton
        rightViewMode = .always
    }

    open func removeRightButton() {
        rightButton = nil
        rightView = rightButton
        rightViewMode = .never
        rightIconContainerSize = 0
    }

    open func removeLeftIcon() {
        leftView = nil
        leftViewMode = .never
        leftIconContainerSize = 0
    }

    open func resetState() {
        let button = Button(type: .custom)
        button.didPressAction = nil
        button.style = DefaultButtonStyle()
        removeRightButton()
        removeLeftIcon()
        inputView = nil
        inputType = FreeTextInputType(textField: self)
        getInputType().render()
        text = DefaultValue.emptyString
        inputAccessoryView = nil
    }

    open func secureInput(_ secure: Bool = true) {
        isSecureTextEntry = secure
        let icon = isSecureTextEntry ? CoreStyle.Image.eyeButtonClose : CoreStyle.Image.eyeButtonOpen
        setRightButton(
            icon: icon,
            style: DefaultButtonStyle(),
            action: { self.secureInput(!self.isSecureTextEntry) }
        )
    }

    open func setEnabled(_ enabled: Bool = true) {
        isEnabled = enabled
        guard let rightButton = rightButton else { return }
        rightButton.isEnabled = enabled
    }

    open func didBeginEditingHandler(_ textField: UITextField) {
        guard let textField = textField as? TextField else { return }
        getInputType().didBeginEditingHandler(textField)
    }

    open func didEndEditingHandler(_ textField: UITextField) {
        guard let textField = textField as? TextField else { return }
        getInputType().didEndEditingHandler(textField)
    }

    @objc func didChange(textField: UITextField, newValue: Any) {
        guard let didChangeAction = didChangeAction else { return }
        guard let textField = textField as? TextField else { return }
        getInputType().didChangeHandler(textField)
        didChangeAction(self, newValue)
    }

    open func getInputType() -> InputType {
        if inputType == nil {
            inputType = FreeTextInputType(textField: self)
        }
        return inputType
    }

    open func setRightButtonEnabled(_ enabled: Bool) {
        guard let rightButton = rightButton else { return }
        rightButton.isEnabled = enabled
    }

    open func shouldChangeCharactersIn(range: NSRange, replacementString string: String) -> Bool {
        return getInputType().shouldChangeCharactersIn(range: range, replacementString: string)
    }

    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        renderBorder()
    }

    override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        guard let inputType = inputType else {
            return super.canPerformAction(action, withSender: sender)
        }
        if !inputType.canPerformAction(action, withSender: sender) { return false }
        return super.canPerformAction(action, withSender: sender)
    }
}

extension TextField: InputProtocol {
    open func getInputView() -> UIView {
        return self
    }

    open func getValue() -> AnyObject {
        if inputType == nil { return DefaultValue.emptyString as AnyObject }
        return getInputType().getValue()
    }

    open func getText() -> String {
        return text ?? DefaultValue.emptyString
    }

    open func resetValue() {
        text = DefaultValue.emptyString
        tag = 0
        getInputType().resetValue()
    }

    open func isEmpty() -> Bool {
        return getText() == DefaultValue.emptyString
    }

    open func setInputType(_ inputType: InputType) {
        self.inputType = inputType
    }

    open func render() {
        getInputType().render()
    }

    public func getTag() -> Int {
        return tag
    }
}
