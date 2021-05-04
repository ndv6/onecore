//
//  CheckboxView.swift
//  ONECore
//
//  Created by DENZA on 05/10/19.
//

import UIKit

open class CheckboxView: UIView {
    private var text: String = DefaultValue.emptyString
    private var highlightedText: String = DefaultValue.emptyString
    private var style: CheckboxStyle = DefaultCheckboxStyle()
    private var value: Bool = false
    private var checkboxImageView: UIImageView = UIImageView()
    private var checkboxButton: Button = Button()
    private var textLabel: Label = Label()
    private var isEnabled: Bool = true
    open var key: String = DefaultValue.emptyString
    open var didChangeAction: InputDidChangeHandler?
    open var didTappedHighlightedText: PressButtonHandler?
    open var didValidationErrorAction: InputDidValidationError?
    open var didValidationSuccessAction: InputDidValidationSuccess?
    open var name: String = DefaultValue.emptyString {
        didSet {
            self.accessibilityIdentifier = String(
                format: AccessibilityIdentifier.checkbox,
                name.toAccessibilityFormat()
            )
        }
    }

    open override func awakeFromNib() {
        super.awakeFromNib()
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
    }

    private func setText(_ text: String, highlightedText: String) {
        self.text = text
        self.textLabel.text = text
        guard highlightedText != DefaultValue.emptyString else { return }
        let range = (text as NSString).range(of: highlightedText)
        let attribute = NSMutableAttributedString(string: text)
        attribute.addAttribute(
            NSAttributedString.Key.foregroundColor,
            value: style.highlightedTextColor ,
            range: range
        )
        attribute.addAttribute(
            NSAttributedString.Key.font,
            value: style.highlightedFont ,
            range: range
        )
        self.textLabel.attributedText = attribute
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(handleTappedHighlightedText)
        )
        textLabel.addGestureRecognizer(tap)
        textLabel.isUserInteractionEnabled = true
    }

    @objc func handleTappedHighlightedText(gesture: UITapGestureRecognizer) {
        let highlightRange = (text as NSString).range(of: highlightedText)
        let index = textLabel.indexOfAttributedTextCharacterAtPoint(
            point: gesture.location(in: textLabel)
        )
        if checkRange(highlightRange, contain: index) == true {
            didTappedHighlightedText?()
            return
        }
    }

    func checkRange(_ range: NSRange, contain index: Int) -> Bool {
        return index > range.location && index < range.location + range.length
    }

    private func renderCheckboxImageView() {
        checkboxImageView = UIImageView()
        checkboxImageView.translatesAutoresizingMaskIntoConstraints = false
        checkboxImageView.isUserInteractionEnabled = true
        checkboxImageView.contentMode = .scaleAspectFit
        addSubview(checkboxImageView)
        createCheckboxImageViewSizeConstraint()
        createCheckboxImageViewOriginConstraint()
        setSelected(value, isRenderOnly: true)
    }

    private func renderCheckboxImage() {
        if !isEnabled {
            checkboxImageView.tintColor = style.disabledColor
        }
        let image = value
            ? style.checkedImage
            : style.uncheckedImage
        let renderingMode = isEnabled
            ? UIImage.RenderingMode.alwaysOriginal
            : UIImage.RenderingMode.alwaysTemplate
        checkboxImageView.image = image.withRenderingMode(renderingMode)
    }

    private func renderText() {
        textLabel = Label()
        textLabel.font = style.font
        textLabel.textColor = style.textColor
        textLabel.textAlignment = .left
        textLabel.contentMode = .topLeft
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.numberOfLines = 0
        textLabel.adjustsFontSizeToFitWidth = true
        textLabel.minimumScaleFactor = 0.5
        addSubview(textLabel)
        createTextLabelHorizontalConstraint()
        createTextLabelVerticalConstraint()
        setText(text, highlightedText: highlightedText)
    }

    private func renderCheckboxButton() {
        checkboxButton = Button()
        checkboxButton.translatesAutoresizingMaskIntoConstraints = false
        checkboxButton.didPressAction = {
            if !self.isEnabled { return }
            self.setSelected(!self.value)
        }
        checkboxButton.backgroundColor = .clear
        addSubview(checkboxButton)
        if style.interactionArea == .checkboxOnly {
            createCheckboxButtonSizeConstraint()
            createCheckboxButtonOriginConstraint()
        } else {
            createCheckboxButtonAllAreaConstraint()
        }
    }

    public func configure(
        text: String = DefaultValue.emptyString,
        highlightedText: String = DefaultValue.emptyString,
        style: CheckboxStyle = DefaultCheckboxStyle(),
        isSelected: Bool = false,
        isEnabled: Bool = true
    ) {
        self.text = text
        self.style = style
        self.value = isSelected
        self.isEnabled = isEnabled
        self.highlightedText = highlightedText
    }

    public func render() {
        removeAllSubviews()
        renderCheckboxImageView()
        renderCheckboxButton()
        renderText()
    }

    public func isSelected() -> Bool {
        return value
    }

    public func setSelected(_ isSelected: Bool, isRenderOnly: Bool = false) {
        self.value = isSelected
        renderCheckboxImage()
        guard let didChangeAction = didChangeAction else { return }
        if !isRenderOnly {
            didChangeAction(self, value)
        }
    }
}

extension CheckboxView: InputProtocol {
    public func getValue() -> AnyObject {
        return value as AnyObject
    }

    public func getText() -> String {
        return textLabel.text ?? DefaultValue.emptyString
    }

    public func getInputView() -> UIView {
        return self
    }

    public func getTag() -> Int {
        return tag
    }

    public func resetValue() {
        setSelected(false)
    }

    public func isEmpty() -> Bool {
        return !value
    }
}

extension CheckboxView {
    private func createCheckboxImageViewSizeConstraint() {
        _ = NSLayoutConstraint(
            item: checkboxImageView,
            attribute: NSLayoutConstraint.Attribute.width,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: nil,
            attribute: NSLayoutConstraint.Attribute.notAnAttribute,
            multiplier: 1,
            constant: style.checkboxSize
        ).isActive = true
        _ = NSLayoutConstraint(
            item: checkboxImageView,
            attribute: NSLayoutConstraint.Attribute.height,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: nil,
            attribute: NSLayoutConstraint.Attribute.notAnAttribute,
            multiplier: 1,
            constant: style.checkboxSize
        ).isActive = true
    }

    private func createCheckboxImageViewOriginConstraint() {
        _ = NSLayoutConstraint(
            item: checkboxImageView,
            attribute: NSLayoutConstraint.Attribute.leading,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self,
            attribute: NSLayoutConstraint.Attribute.leading,
            multiplier: 1,
            constant: DefaultValue.emptyCGFloat
        ).isActive = true
        let veritcalAttribute = style.checkboxVerticalPosition == .center
            ? NSLayoutConstraint.Attribute.centerY
            : NSLayoutConstraint.Attribute.top
        _ = NSLayoutConstraint(
            item: checkboxImageView,
            attribute: veritcalAttribute,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self,
            attribute: veritcalAttribute,
            multiplier: 1,
            constant: DefaultValue.emptyCGFloat
        ).isActive = true
    }

    private func createTextLabelHorizontalConstraint() {
        _ = NSLayoutConstraint(
            item: textLabel,
            attribute: NSLayoutConstraint.Attribute.leading,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: checkboxImageView,
            attribute: NSLayoutConstraint.Attribute.trailing,
            multiplier: 1,
            constant: style.spacing
        ).isActive = true
        _ = NSLayoutConstraint(
            item: textLabel,
            attribute: NSLayoutConstraint.Attribute.trailing,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self,
            attribute: NSLayoutConstraint.Attribute.trailing,
            multiplier: 1,
            constant: DefaultValue.emptyCGFloat
        ).isActive = true
    }

    private func createTextLabelVerticalConstraint() {
        _ = NSLayoutConstraint(
            item: textLabel,
            attribute: NSLayoutConstraint.Attribute.top,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self,
            attribute: NSLayoutConstraint.Attribute.top,
            multiplier: 1,
            constant: DefaultValue.emptyCGFloat
        ).isActive = true
        _ = NSLayoutConstraint(
            item: textLabel,
            attribute: NSLayoutConstraint.Attribute.bottom,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self,
            attribute: NSLayoutConstraint.Attribute.bottom,
            multiplier: 1,
            constant: DefaultValue.emptyCGFloat
        ).isActive = true
    }

    private func createCheckboxButtonSizeConstraint() {
        _ = NSLayoutConstraint(
            item: checkboxButton,
            attribute: NSLayoutConstraint.Attribute.width,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: nil,
            attribute: NSLayoutConstraint.Attribute.notAnAttribute,
            multiplier: 1,
            constant: style.checkboxSize
        ).isActive = true
        _ = NSLayoutConstraint(
            item: checkboxButton,
            attribute: NSLayoutConstraint.Attribute.height,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: nil,
            attribute: NSLayoutConstraint.Attribute.notAnAttribute,
            multiplier: 1,
            constant: style.checkboxSize
        ).isActive = true
    }

    private func createCheckboxButtonOriginConstraint() {
        _ = NSLayoutConstraint(
            item: checkboxButton,
            attribute: NSLayoutConstraint.Attribute.leading,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self,
            attribute: NSLayoutConstraint.Attribute.leading,
            multiplier: 1,
            constant: DefaultValue.emptyCGFloat
        ).isActive = true
        let veritcalAttribute = style.checkboxVerticalPosition == .center
            ? NSLayoutConstraint.Attribute.centerY
            : NSLayoutConstraint.Attribute.top
        _ = NSLayoutConstraint(
            item: checkboxButton,
            attribute: veritcalAttribute,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self,
            attribute: veritcalAttribute,
            multiplier: 1,
            constant: DefaultValue.emptyCGFloat
        ).isActive = true
    }

    private func createCheckboxButtonAllAreaConstraint() {
        _ = NSLayoutConstraint(
            item: checkboxButton,
            attribute: NSLayoutConstraint.Attribute.leading,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self,
            attribute: NSLayoutConstraint.Attribute.leading,
            multiplier: 1,
            constant: DefaultValue.emptyCGFloat
        ).isActive = true
        _ = NSLayoutConstraint(
            item: checkboxButton,
            attribute: NSLayoutConstraint.Attribute.trailing,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self,
            attribute: NSLayoutConstraint.Attribute.trailing,
            multiplier: 1,
            constant: DefaultValue.emptyCGFloat
        ).isActive = true
        _ = NSLayoutConstraint(
            item: checkboxButton,
            attribute: NSLayoutConstraint.Attribute.top,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self,
            attribute: NSLayoutConstraint.Attribute.top,
            multiplier: 1,
            constant: DefaultValue.emptyCGFloat
        ).isActive = true
        _ = NSLayoutConstraint(
            item: checkboxButton,
            attribute: NSLayoutConstraint.Attribute.bottom,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self,
            attribute: NSLayoutConstraint.Attribute.bottom,
            multiplier: 1,
            constant: DefaultValue.emptyCGFloat
        ).isActive = true
    }
}
