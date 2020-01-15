//
//  PickerInputType.swift
//  ONECore
//
//  Created by Steven Tiolie on 07/01/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import UIKit

open class PickerInputType: InputType {
    open var identifier: InputTypeIdentifier = .picker
    private var overlay: Button = Button()
    private var instruction: String = DefaultValue.emptyString
    private var textField: TextField = TextField()
    private var sender: FormTableViewController = FormTableViewController()
    open var pickerView = UIPickerView()
    open var items = [String]()
    open var instructionFont: UIFont = UIFont()
    open var instructionColor: UIColor = .clear
    open var buttonFont: UIFont = UIFont()
    open var buttonColor: UIColor = .clear
    open var borderWidth: CGFloat = 0
    open var borderColor: UIColor = .clear
    open var doneButtonText: String = DefaultValue.emptyString
    open func didBeginEditingHandler(_ textField: TextField) {}
    open func didEndEditingHandler(_ textField: TextField) {}
    open func didChangeHandler(_ textField: TextField) {}
    open func resetValue() {}

    public init(textField: TextField, instruction: String, sender: FormTableViewController, items: [String], defaultValue: String? = nil) {
        self.textField = textField
        self.instruction = instruction
        self.sender = sender
        self.items = items
        pickerView.delegate = sender
        pickerView.dataSource = sender
        pickerView.backgroundColor = .white
        guard let date = defaultValue else { return }
        self.textField.text = date
    }

    @objc private func close() {
        textField.resignFirstResponder()
        overlay.isHidden = true
        guard let didChangeAction = textField.didChangeAction else { return }
        didChangeAction(textField, textField.text ?? DefaultValue.emptyString)
    }

    @objc private func done() {
        let row = pickerView.selectedRow(inComponent: 0)
        textField.text = String(items[row])
        close()
    }

    private func createToolBar() {
        let toolBar = UIToolbar()
        toolBar.setItems([
            createInstruction(),
            createToolbarSpacing(),
            createDoneButton()
            ], animated: false)
        toolBar.barStyle = .default
        toolBar.tintColor = buttonColor
        toolBar.isTranslucent = false
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
        button.setTitleTextAttributes([NSAttributedString.Key.font: buttonFont], for: .normal)
        button.setTitleTextAttributes([NSAttributedString.Key.font: buttonFont], for: .highlighted)
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
        instructionLabel.font = instructionFont
        instructionLabel.textColor = instructionColor
        return UIBarButtonItem(customView: instructionLabel)
    }

    private func createOverlay() {
        overlay = Button(frame: CGRect(x: 0, y: 0, width: sender.view.frame.width, height: sender.view.frame.height))
        overlay.didPressAction = close
        overlay.backgroundColor = UIColor.black
        overlay.alpha = 0.8
        overlay.isHidden =  true
        sender.navigationController?.view.addSubview(overlay)
        sender.navigationController?.view.bringSubviewToFront(overlay)
    }

    private func renderBorder() {
        pickerView.layer.borderWidth = borderWidth
        pickerView.layer.borderColor = borderColor.cgColor
    }

    open func render() {
        textField.inputView = pickerView
        createToolBar()
        createOverlay()
        renderBorder()
    }

    open func getValue() -> AnyObject {
        let row = pickerView.selectedRow(inComponent: 0)
        let value = String(items[row])
        return value as AnyObject
    }

    open func getDisplayText() -> String {
        return textField.getText()
    }

    open func shouldChangeCharactersIn(range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}
