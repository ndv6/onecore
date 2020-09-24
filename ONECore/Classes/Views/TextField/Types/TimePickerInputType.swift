//
//  TimePickerInputType.swift
//  Alamofire
//
//  Created by ALDO LAZUARDI on 03/06/20.
//

import UIKit

open class TimePickerInputType: InputType {
    private var overlay: Button = Button()
    private var instruction: String = DefaultValue.emptyString
    private var textField: TextField = TextField()
    private var presenter: UINavigationController = UINavigationController()
    private var datePicker = UIDatePicker()
    open var identifier: InputTypeIdentifier = .timePicker
    open var doneButtonText: String = DefaultValue.emptyString
    open var locale: Locale = Locale(identifier: DateLocale.indonesian) {
        didSet {
            datePicker.locale = locale
        }
    }
    public var style: DatePickerStyle = TimeDatePickerStyle() {
        didSet { applyStyle() }
    }

    open func didChangeHandler(_ textField: TextField) {}
    open func resetValue() {}
    open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return true
    }

    public init(
        textField: TextField,
        instruction: String = DefaultValue.emptyString,
        presenter: UINavigationController,
        minimumDate: Date?,
        maximumDate: Date?
    ) {
        self.textField = textField
        self.instruction = instruction
        self.presenter = presenter
        datePicker.backgroundColor = .white
        datePicker.minimumDate = minimumDate
        datePicker.maximumDate = maximumDate
        datePicker.datePickerMode = .time
    }

    private func applyStyle() {
        render()
    }

    @objc private func close() {
        textField.resignFirstResponder()
        overlay.isHidden = true
    }

    @objc private func done() {
        setValue(datePicker.date)
        close()
    }

    private func createToolBar() {
        if doneButtonText.isEmpty && instruction.isEmpty { return }
        let toolBar = UIToolbar()
        toolBar.setItems([
            createInstruction(),
            createToolbarSpacing(),
            createDoneButton()
        ], animated: false)
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
        return UIBarButtonItem(
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
        datePicker.layer.borderWidth = style.borderWidth
        datePicker.layer.borderColor = style.borderColor.cgColor
    }

    private func renderCalendarButton() {
        textField.setRightButton(
            icon: style.calendarButtonImage,
            style: style.calendarButtonStyle,
            action: {
                self.didBeginEditingHandler(self.textField)
            }
        )
    }

    open func render() {
        textField.inputView = datePicker
        createToolBar()
        createOverlay()
        renderBorder()
    }

    open func didBeginEditingHandler(_ textField: TextField) {
        textField.becomeFirstResponder()
        overlay.isHidden = false
    }

    open func getValue() -> AnyObject {
        return datePicker.date as AnyObject
    }

    public func setValue(_ value: Date?) {
        guard let value = value else { return }
        datePicker.date = value
        textField.text = value.formatIn(
            format: style.displayFormat,
            locale: locale
        )
        textField.didChange(textField: textField, newValue: value)
    }

    open func getOriginalText() -> String {
        return textField.text ?? DefaultValue.emptyString
    }

    open func getDisplayText() -> String {
        return textField.getText()
    }

    open func shouldChangeCharactersIn(range: NSRange, replacementString string: String) -> Bool {
        return true
    }

    open func didEndEditingHandler(_ textField: TextField) {
        if !doneButtonText.isEmpty { return }
        setValue(datePicker.date)
    }
}
