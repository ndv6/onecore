//
//  InputType.swift
//  ONECore
//
//  Created by DENZA on 23/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import Foundation

public enum InputTypeIdentifier {
    case freetext
    case dropdown
    case datepicker
    case picker
    case amount
    case monthYearpicker
}

public protocol InputType {
    var identifier: InputTypeIdentifier { get }
    func render()
    func resetValue()
    func getValue() -> AnyObject
    func getDisplayText() -> String
    func didBeginEditingHandler(_ textField: TextField)
    func didEndEditingHandler(_ textField: TextField)
    func didChangeHandler(_ textField: TextField)
    func shouldChangeCharactersIn(range: NSRange, replacementString string: String) -> Bool
}
