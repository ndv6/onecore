//
//  DropDownInputType.swift
//  ONECore
//
//  Created by DENZA on 23/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

public typealias DropDownTextFormatHandler = (_ option: Option) -> String

open class DropDownInputType: InputType {
    private var controller: DropDownViewController = DropDownViewController()
    private var navigationController: UINavigationController = UINavigationController()
    private var textField: TextField = TextField()
    private var arrowImage: UIImage = CoreStyle.Image.dropDownArrow
    open var identifier: InputTypeIdentifier = .dropdown
    open var arrowStyle: ButtonStyle = DefaultButtonStyle()
    open func didEndEditingHandler(_ textField: TextField) {}
    open func didChangeHandler(_ textField: TextField) {}
    open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return true
    }

    public init(
        textField: TextField,
        navigationController: UINavigationController,
        controller: DropDownViewController = DropDownViewController(),
        defaultValue: Option = Option(),
        textFormat: DropDownTextFormatHandler? = nil,
        arrowImage: UIImage = CoreStyle.Image.dropDownArrow
    ) {
        self.textField = textField
        self.navigationController = navigationController
        self.controller = controller
        self.arrowImage = arrowImage
        if defaultValue.identifier != DefaultValue.emptyString {
            self.controller.selectedOption = defaultValue
            self.textField.text = defaultValue.text
        }
    }

    private func didSelectOption(_ option: Option) {
        textField.text = option.text
        guard let didChange = textField.didChangeAction else { return }
        didChange(textField, option)
    }

    open func render() {
        textField.setRightButton(
            icon: arrowImage,
            style: arrowStyle,
            action: {
                self.didBeginEditingHandler(self.textField)
            }
        )
    }

    open func didBeginEditingHandler(_ textField: TextField) {
        controller.didSelectAction = didSelectOption
        navigationController.pushViewController(controller, animated: true)
    }

    open func getValue() -> AnyObject {
        return controller.selectedOption as AnyObject
    }

    open func getDisplayText() -> String {
        return textField.getText()
    }

    open func resetValue() {
        controller.didLoadData = false
        controller.resetSelection()
    }

    open func setController(controller: DropDownViewController) {
        self.controller = controller
    }

    open func shouldChangeCharactersIn(range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}
