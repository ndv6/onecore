//
//  InputProtocol.swift
//  ONECore
//
//  Created by DENZA on 27/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

public typealias InputDidChangeHandler = (_ input: InputProtocol, _ newValue: Any) -> Void
public typealias InputDidValidationError = (_ status: ValidationStatus) -> Void
public typealias InputDidValidationSuccess = (_ status: ValidationStatus) -> Void

public protocol InputProtocol {
    var key: String { get set }
    var name: String { get set }
    var didChangeAction: InputDidChangeHandler? { get set }
    var didValidationErrorAction: InputDidValidationError? { get set }
    var didValidationSuccessAction: InputDidValidationSuccess? { get set }
    func getValue() -> AnyObject
    func getText() -> String
    func getInputView() -> UIView
    func getTag() -> Int
    func resetValue()
    func isEmpty() -> Bool
}
