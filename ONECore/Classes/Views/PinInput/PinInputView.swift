//
//  PinInputView.swift
//  ONECore
//
//  Created by Sofyan Fradenza Adi on 20/09/19.
//

import UIKit

public enum PinInputType {
    case numeric
    case alphanumeric
}

public protocol PinInputViewDelegate: class {
    func pinInputViewDidChangedValue(_ value: String)
}

open class PinInputView: UIView {
    private var keyboardType: UIKeyboardType = .numberPad
    private var length: Int = DefaultValue.emptyInt
    private var panViews: [PinPanView] = [PinPanView]()
    private var panWidth: CGFloat = DefaultValue.emptyCGFloat
    private var panSpacing: CGFloat = DefaultValue.emptyCGFloat
    private var keyboardButton: Button = Button()
    private var textField: TextField = TextField()
    private var style: PinInputStyle = DefaultPinInputStyle()
    public weak var delegate: PinInputViewDelegate?

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
    }

    @objc private func didChangedValue() {
        let text = textField.getText()
        if text == getValue() { return }
        for index in 0...panViews.count - 1 {
            panViews[index].updateValue(text[index])
        }
        if text.count >= length {
            textField.resignFirstResponder()
        }
        delegate?.pinInputViewDidChangedValue(text)
    }

    private func calibratePanWidth(containerSize: CGSize) {
        if panWidth < DefaultValue.emptyCGFloat {
            panWidth = DefaultValue.emptyCGFloat
            return
        }
        let maxPanWidth = containerSize.width / CGFloat(length)
        if panWidth > maxPanWidth {
            panWidth = maxPanWidth
            return
        }
    }

    private func calibratePanSpacing(containerSize: CGSize) {
        let numberOfSpacing = length - 1
        let freeSpace = containerSize.width - getTotalPanWidth()
        let maxPanSpacing = freeSpace / CGFloat(numberOfSpacing)
        if panSpacing <= DefaultValue.emptyCGFloat || panSpacing > maxPanSpacing {
            panSpacing = maxPanSpacing
        }
    }

    private func getTotalPanWidth() -> CGFloat {
        return panWidth * CGFloat(length)
    }

    private func getTotalPanSpacing() -> CGFloat {
        return panSpacing * CGFloat(length - 1)
    }

    private func getContainerPadding(containerSize: CGSize) -> CGFloat {
        let remainingWidth = containerSize.width - getTotalPanWidth() - getTotalPanSpacing()
        return remainingWidth / 2
    }

    private func renderPanViews(containerSize: CGSize) {
        panViews.removeAll()
        calibratePanWidth(containerSize: containerSize)
        calibratePanSpacing(containerSize: containerSize)
        if panWidth == DefaultValue.emptyCGFloat { return }
        let containerPadding = getContainerPadding(containerSize: containerSize)
        for index in 0...(length - 1) {
            let frame = CGRect(
                x: containerPadding + (panWidth * CGFloat(index)) + (panSpacing * CGFloat(index)),
                y: DefaultValue.emptyCGFloat,
                width: panWidth,
                height: containerSize.height
            )
            let panView = PinPanView(frame: frame)
            panView.render(style: style)
            panView.setValue(textField.getText()[index])
            panViews.append(panView)
            addSubview(panView)
        }
    }

    private func renderTextField() {
        textField.style = InvisibleTextFieldStyle()
        textField.delegate = self
        textField.maxLength = length
        textField.keyboardType = keyboardType
        textField.addTarget(
            self,
            action: #selector(PinInputView.didChangedValue),
            for: .editingChanged
        )
        addSubview(textField)
    }

    private func renderKeyboardButton(containerSize: CGSize) {
        keyboardButton.frame.size = containerSize
        keyboardButton.backgroundColor = .clear
        keyboardButton.didPressAction = {
            self.textField.becomeFirstResponder()
        }
        addSubview(keyboardButton)
    }

    public func configure(
        length: Int,
        panWidth: CGFloat = DefaultValue.emptyCGFloat,
        panSpacing: CGFloat = DefaultValue.emptyCGFloat,
        keyboardType: UIKeyboardType = UIKeyboardType.numberPad,
        style: PinInputStyle = DefaultPinInputStyle()
    ) {
        self.keyboardType = keyboardType
        self.length = length
        self.panWidth = panWidth
        self.panSpacing = panSpacing
        self.style = style
    }

    public func render() {
        self.layoutIfNeeded()
        let containerSize = bounds.size
        if containerSize.width == DefaultValue.emptyCGFloat { return }
        removeAllSubviews()
        renderTextField()
        renderPanViews(containerSize: CGSize(width: 320, height: 64))
        renderKeyboardButton(containerSize: CGSize(width: 320, height: 64))
        didChangedValue()
    }

    public func getValue() -> String {
        var value = DefaultValue.emptyString
        for panView in panViews {
            value += String(panView.getValue())
        }
        return value
    }

    public func resetValue() {
        textField.text = DefaultValue.emptyString
    }

    public func setValue(_ value: String) {
        textField.text = value
    }

    public func setEnabled(_ isEnabled: Bool = true) {
        keyboardButton.isUserInteractionEnabled = isEnabled
    }

    public func setFirstResponder() {
        DispatchQueue.main.async {
            self.textField.becomeFirstResponder()
        }
    }
}

extension PinInputView: UITextFieldDelegate {
    public func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        guard let coreTextField: TextField = textField as? TextField else { return true }
        guard let initialText: String = coreTextField.text else { return true }
        let isValidLength = coreTextField.maxLength == 0
            || initialText.count + string.count - range.length <= coreTextField.maxLength
        let result = isValidLength && coreTextField.shouldChangeCharactersIn(
            range: range,
            replacementString: string
        )
        if !result { textField.resignFirstResponder() }
        return result
    }
}
