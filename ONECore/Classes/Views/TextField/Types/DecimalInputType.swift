//
//  DecimalInputType.swift
//  Alamofire
//
//  Created by Sofyan Fradenza Adi on 30/04/19.
//

import UIKit

open class DecimalInputType: InputType {
    private var textField: TextField = TextField()
    private var activeIcon: UIImage?
    private var inactiveIcon: UIImage?
    open var identifier: InputTypeIdentifier = .freetext
    public func didBeginEditingHandler(_ textField: TextField) {}
    public func didEndEditingHandler(_ textField: TextField) {}
    public func didChangeHandler(_ textField: TextField) {}
    public func resetValue() {}
    open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return true
    }

    public init(
        textField: TextField,
        defaultValue: Double? = nil,
        activeIcon: UIImage? = nil,
        inactiveIcon: UIImage? = nil
    ) {
        self.textField = textField
        self.activeIcon = activeIcon
        self.inactiveIcon = inactiveIcon
        guard let defaultValue = defaultValue else { return }
        self.textField.text = defaultValue.clean
    }

    open func render() {
        guard let activeIcon = activeIcon else { return }
        guard let inactiveIcon = inactiveIcon else { return }
        textField.setRightIcon(textField.isEmpty() ? inactiveIcon : activeIcon)
    }

    open func getValue() -> AnyObject {
        guard let text = textField.text else { return DefaultValue.emptyFloat as AnyObject }
        return text.floatValue as AnyObject
    }

    open func getDisplayText() -> String {
        return textField.getText()
    }

    open func shouldChangeCharactersIn(range: NSRange, replacementString string: String) -> Bool {
        if string.isBackspace() { return true }
        guard let text = textField.text else { return true }
        if !string.contains(Separator.decimalID) && !string.contains(Separator.decimalEN) { return true }
        if text.isEmpty { return false }
        return !text.contains(Separator.decimalEN) && !text.contains(Separator.decimalID)
    }
}
