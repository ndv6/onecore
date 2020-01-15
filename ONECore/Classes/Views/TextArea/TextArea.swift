//
//  TextArea.swift
//  ONECore
//
//  Created by DENZA on 22/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

public typealias TextAreaDidChangeHandler = (_ textarea: TextArea) -> Void

open class TextArea: UITextView {
    private var showingPlaceholder: Bool = false
    internal var bottomLineLayer: CALayer = CALayer()
    public var key: String = DefaultValue.emptyString
    public var name: String = DefaultValue.emptyString
    public var style: TextFieldStyle! {
        didSet {
            applyStyle()
        }
    }
    public var placeholder: String = DefaultValue.emptyString {
        didSet {
            renderPlaceholder(text: placeholder)
        }
    }
    public var didChangeAction: InputDidChangeHandler?
    public var didValidationErrorAction: InputDidValidationError?
    public var didValidationSuccessAction: InputDidValidationSuccess?
    public var maxLength: Int = 255

    override open func awakeFromNib() {
        super.awakeFromNib()
        scrollRangeToVisible(NSRange(location: 0, length: 0))
        setValue(DefaultValue.emptyString)
    }

    private func applyStyle() {
        font = style.font
        textColor = showingPlaceholder ? style.placeholderColor : style.color
        backgroundColor = style.backgroundColor
        textContainerInset = style.padding
        renderBorder()
    }

    private func renderPlaceholder(text: String) {
        showingPlaceholder = true
        autocorrectionType = .no
        textColor = style.placeholderColor
        selectedTextRange = textRange(from: beginningOfDocument, to: beginningOfDocument)
        if self.text != text {
            self.text = text
            didChange(self)
        }
    }

    private func didChange(_ textArea: TextArea) {
        guard let didChangeAction = didChangeAction else { return }
        didChangeAction(self, textArea.text)
    }

    open func shouldChangeTextHandler(range: NSRange, replacementText text: String) -> Bool {
        let currentText: String = self.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        if updatedText.count > maxLength {
            return false
        }
        if updatedText.isEmpty {
            renderPlaceholder(text: placeholder)
            return false
        }
        if showingPlaceholder && !text.isEmpty {
            setValue(text)
            return false
        }
        didChange(self)
        return true
    }

    open func didChangeSelectionHandler() {
        if showingPlaceholder {
            selectedTextRange = textRange(from: beginningOfDocument, to: beginningOfDocument)
        }
    }

    open func setValue(_ text: String) {
        if text.isEmpty {
            renderPlaceholder(text: placeholder)
            return
        }
        showingPlaceholder = false
        autocorrectionType = .yes
        self.text = text
        textColor = style.color
        didChange(self)
    }

    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        applyStyle()
    }
}

extension TextArea: InputProtocol {
    public func getInputView() -> UIView {
        return self
    }

    public func getValue() -> AnyObject {
        return getText() as AnyObject
    }

    public func getText() -> String {
        if showingPlaceholder { return DefaultValue.emptyString }
        return text ?? DefaultValue.emptyString
    }

    public func resetValue() {
        text = DefaultValue.emptyString
        tag = 0
    }

    public func isEmpty() -> Bool {
        return showingPlaceholder || getText() == DefaultValue.emptyString
    }

    public func getTag() -> Int {
        return tag
    }
}
