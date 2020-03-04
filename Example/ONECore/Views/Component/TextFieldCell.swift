//
//  TextFieldCell.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 04/03/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import ONECore

class TextFieldCell: TableViewCell {
    @IBOutlet internal weak var container: UIView!
    @IBOutlet internal weak var textField: TextField!
    @IBOutlet internal weak var hintLabel: Label!
    @IBOutlet internal weak var titleLabel: Label!
    @IBOutlet internal weak var errorLabel: Label!
    @IBOutlet internal weak var containerLeading: NSLayoutConstraint!
    @IBOutlet internal weak var containerTrailing: NSLayoutConstraint!
    @IBOutlet internal weak var containerBottom: NSLayoutConstraint!
    @IBOutlet internal weak var containerTop: NSLayoutConstraint!
    @IBOutlet internal weak var constraintContainerTop: NSLayoutConstraint!
    @IBOutlet internal weak var microButton: Button!
    @IBOutlet weak var microActivityIndicator: UIActivityIndicatorView!
    internal var validationRules: [Rule] = [Rule]()
    internal var hintMessage: String = DefaultValue.emptyString {
        didSet {
            hintLabel.text = hintMessage
        }
    }
    private var errorState: Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()
        initState()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        initState()
    }

    private func initState() {
        textField.resetState()
        dismissError()
        container.backgroundColor = .clear
        let style = RegularTextFieldStyle()
        textField.style = style
        textField.didValidationErrorAction = { (_ status: ValidationStatus) in
            self.showError(message: status.message)
        }
        textField.didValidationSuccessAction = { (_ status: ValidationStatus) in
            self.dismissError()
        }
        titleLabel.text = DefaultValue.emptyString
        hintLabel.text = DefaultValue.emptyString
        errorLabel.text = DefaultValue.emptyString
        microButton.setTitle(DefaultValue.emptyString, for: .normal)
        microButton.isHidden = true
        microActivityIndicator.stopAnimating()
    }

    func startLoading() {
        textField.setEnabled(false)
        microButton.isHidden = true
        microActivityIndicator.isHidden = false
        microActivityIndicator.startAnimating()
    }

    func stopLoading() {
        microActivityIndicator.isHidden = true
        microActivityIndicator.stopAnimating()
        if microButton.titleLabel?.text != DefaultValue.emptyString {
            microButton.isHidden = false
        }
        textField.setEnabled(true)
    }

    func showError(message: String) {
        errorState = true
        errorLabel.text = message
        hintLabel.text = DefaultValue.emptyString
    }

    func dismissError() {
        errorState = false
        errorLabel.text = DefaultValue.emptyString
        hintLabel.text = hintMessage
    }

    func inErrorState() -> Bool {
        return errorState
    }

    func hideTitle() {
        titleLabel.isHidden = true
    }
}
