//
//  MonthYearPickerInputType.swift
//  Alamofire
//
//  Created by ALDO LAZUARDI on 25/09/19.
//

import UIKit

open class MonthYearPickerInputType {
    open var identifier: InputTypeIdentifier = .monthYearpicker
    private var overlay: Button = Button()
    private var instruction: String = DefaultValue.emptyString
    private var textField: TextField = TextField()
    private var presenter: UINavigationController = UINavigationController()
    private var monthYearPicker = MonthYearPickerView()
    open var doneButtonText: String = DefaultValue.emptyString
    open var locale: Locale = Locale(identifier: DateLocale.indonesian) {
        didSet {
            monthYearPicker.locale = locale
        }
    }
    public var style: DatePickerStyle = DefaultDatePickerStyle() {
        didSet { applyStyle() }
    }

    public init(
        textField: TextField,
        instruction: String = DefaultValue.emptyString,
        presenter: UINavigationController,
        minimumDate: Date,
        maximumDate: Date,
        locale: Locale = Locale(identifier: DateLocale.indonesian)
    ) {
        self.textField = textField
        self.instruction = instruction
        self.presenter = presenter
        monthYearPicker.locale = locale
        monthYearPicker.configure(minimumDate: minimumDate, maximumDate: maximumDate)
        monthYearPicker.backgroundColor = style.backgroundColor
    }

    public func setValue(_ value: Date?) {
        guard let value = value else { return }
        monthYearPicker.selectedDate = value
        textField.text = value.formatIn(
            format: style.displayFormat,
            locale: locale
        )
        textField.didChange(textField: textField, newValue: value)
    }

    @objc private func close() {
        textField.resignFirstResponder()
        overlay.isHidden = true
        guard let didChangeAction = textField.didChangeAction else { return }
        didChangeAction(textField, monthYearPicker.selectedDate)
    }

    @objc private func done() {
        setValue(monthYearPicker.selectedDate)
        close()
    }

    private func createToolBar() {
        let toolBar = UIToolbar()
        toolBar.setItems(
            [
                createInstruction(),
                createToolbarSpacing(),
                createDoneButton()
            ],
            animated: false
        )
        toolBar.barStyle = style.toolBarStyle
        toolBar.tintColor = style.toolBarTintColor
        toolBar.isTranslucent = style.isToolBarTranslucent
        toolBar.sizeToFit()
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }

    private func createDoneButton() -> UIBarButtonItem {
        let button = UIBarButtonItem(
            title: doneButtonText,
            style: .plain,
            target: self,
            action: #selector(self.done)
        )
        button.setTitleTextAttributes(
            [NSAttributedString.Key.font: style.doneButtonFont],
            for: .normal
        )
        button.setTitleTextAttributes(
            [NSAttributedString.Key.font: style.doneButtonFont],
            for: .highlighted
        )
        return button
    }

    private func createToolbarSpacing() -> UIBarButtonItem {
        return UIBarButtonItem (
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
    }

    private func createInstruction() -> UIBarButtonItem {
        let instructionLabel = Label()
        instructionLabel.text = instruction
        instructionLabel.font = style.instructionFont
        instructionLabel.textColor = style.instructionColor
        return UIBarButtonItem(customView: instructionLabel)
    }

    private func createOverlay() {
        if !style.isOverlayVisible { return }
        overlay = Button(frame: CGRect(
            x: 0,
            y: 0,
            width: presenter.view.frame.width,
            height: presenter.view.frame.height
        ))
        overlay.didPressAction = close
        overlay.backgroundColor = UIColor.black
        overlay.alpha = 0.8
        overlay.isHidden =  true
        presenter.view.addSubview(overlay)
        presenter.view.bringSubviewToFront(overlay)
    }

    private func renderBorder() {
        monthYearPicker.layer.borderWidth = style.borderWidth
        monthYearPicker.layer.borderColor = style.borderColor.cgColor
    }

    private func renderCalendarButton() {
        self.textField.setRightButton(
            icon: style.calendarButtonImage,
            style: style.calendarButtonStyle,
            action: {
                self.didBeginEditingHandler(self.textField)
            }
        )
        self.textField.tintColor = style.textFieldTintColor
    }

    private func applyStyle() {
        render()
    }
}

extension MonthYearPickerInputType: InputType {
    open func didEndEditingHandler(_ textField: TextField) {
        if !doneButtonText.isEmpty { return }
        setValue(monthYearPicker.selectedDate)
    }

    open func didChangeHandler(_ textField: TextField) {}

    open func resetValue() {}

    open func render() {
        textField.inputView = monthYearPicker
        renderCalendarButton()
        createToolBar()
        createOverlay()
        renderBorder()
    }

    open func didBeginEditingHandler(_ textField: TextField) {
        textField.becomeFirstResponder()
        overlay.isHidden = false
    }

    open func getValue() -> AnyObject {
        return monthYearPicker.selectedDate as AnyObject
    }

    open func getDisplayText() -> String {
        return textField.getText()
    }

    open func shouldChangeCharactersIn(range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}
