//
//  FormTableViewController.swift
//  ONECore
//
//  Created by DENZA on 07/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

open class FormTableViewController: TableViewController {
    private var keyboardNotification: NSNotification?
    private var inputValidators: [InputValidator] = [InputValidator]()
    private var isShowingKeyboard: Bool = false
    open func didValidationSuccess() {}
    open func didValidationFailed() {}
    open func didChangeInput(_ input: InputProtocol, _ newValue: Any) {}

    override open func viewDidLoad() {
        super.viewDidLoad()
        addKeyboardListener()
    }

    public func getInputValidators() -> [InputValidator] {
        return inputValidators
    }

    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }

    open func registerInput(_ input: InputProtocol, rules: [Rule] = [Rule]()) {
        let newTag = inputValidators.count + 1
        if let field = input as? TextField {
            if let pickerInput = field.getInputType() as? PickerInputType {
                pickerInput.pickerView.tag = newTag
            } else {
                field.tag = newTag
            }
        } else if let field = input as? TextArea {
            field.tag = newTag
        }
        inputValidators.append(InputValidator(input: input, rules: rules))
    }

    open func getNextInput(currentInput: UITextField) -> InputProtocol? {
        for inputValidator in inputValidators {
            if inputValidator.input.getTag() > currentInput.tag {
                return inputValidator.input
            }
        }
        return nil
    }

    private func addKeyboardListener() {
        if !CoreConfig.FormTableViewController.isAutoAvoidKeyboard { return }
        let showSelector = #selector(FormTableViewController.keyboardWillShow(notification:))
        let hideSelector = #selector(FormTableViewController.keyboardWillHide(notification:))
        NotificationCenter.default.addObserver(
            self,
            selector: showSelector,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: hideSelector,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc open func keyboardWillShow(notification: NSNotification? = nil) {
        isShowingKeyboard = true
        var currentNotification: NSNotification?
        if notification == nil, let keyboardNotification = keyboardNotification {
            currentNotification = keyboardNotification
        } else if notification != nil {
            currentNotification = notification
            keyboardNotification = currentNotification
        } else { return }
        guard let notif = currentNotification else { return }
        guard let userInfo = notif.userInfo else { return }
        guard let keyboard = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: keyboard.cgRectValue.height, right: 0)
        contentView.tableView.contentInset = insets
        contentView.tableView.scrollIndicatorInsets = insets
    }

    @objc open func keyboardWillHide(notification: NSNotification) {
        isShowingKeyboard = false
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        contentView.tableView.contentInset = insets
        contentView.tableView.scrollIndicatorInsets = insets
    }

    public func scrollToInput(_ input: InputProtocol) {
        guard let row = input.getInputView().getParentCell() else { return }
        if contentView.numberOfRows() == 1 {
            contentView.scrollToVisible(row: row)
        } else {
            contentView.scrollTo(row: row)
        }
    }

    open func validateForm() {
        var topInvalidInput: InputProtocol?
        for validator in inputValidators {
            let status = validator.validate()
            if status.isValid { continue }
            if topInvalidInput == nil {
                topInvalidInput = validator.input
            }
            guard let callback = validator.input.didValidationErrorAction else { continue }
            callback(status)
        }
        if let invalidInput = topInvalidInput {
            didValidationFailed()
            reloadTableView()
            scrollToInput(invalidInput)
        } else {
            didValidationSuccess()
            reloadTableView()
        }
    }

    public func resetValidator() {
        inputValidators.removeAll()
    }

    public func refreshErrorMessage() {
        for validator in inputValidators {
            if validator.getLastStatus().isValid { continue }
            let status = validator.validate()
            if status.isValid {
                guard let callback = validator.input.didValidationSuccessAction else { continue }
                callback(status)
            } else {
                guard let callback = validator.input.didValidationErrorAction else { continue }
                callback(status)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            if self.isShowingKeyboard { return }
            self.reloadTableView()
        }
    }

    public func isRequiredInputCompleted() -> Bool {
        for validator in inputValidators {
            let status = validator.validate(
                ruleType: RequiredRule.self,
                isNeedToTrackResult: false
            )
            if !status.isValid {
                return false
            }
        }
        return true
    }

    override open func render() {
        super.render()
        inputValidators.removeAll()
    }
}
