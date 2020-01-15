//
//  FormTableViewController+UIPickerView.swift
//  ONECore
//
//  Created by Steven Tiolie on 08/01/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import UIKit

extension FormTableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    public func getPickerInput(_ pickerView: UIPickerView) -> PickerInputType {
        for inputValidator in getInputValidators() {
            guard let field = inputValidator.input as? TextField else { continue }
            guard let inputType = field.getInputType() as? PickerInputType else { continue }
            if inputType.pickerView.tag == pickerView.tag {
                return inputType
            }
        }
        return  PickerInputType(
            textField: TextField(),
            instruction: DefaultValue.emptyString,
            sender: self,
            items: [String](),
            defaultValue: DefaultValue.emptyString)
    }

    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let type = getPickerInput(pickerView)
        return type.items.count
    }

    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let type = getPickerInput(pickerView)
        return String(type.items[row])
    }
}
