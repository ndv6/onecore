//
//  DatePickerViewStyle.swift
//  Alamofire
//
//  Created by ALDO LAZUARDI on 01/10/19.
//

import UIKit

@objc public protocol DatePickerStyle {
    var backgroundColor: UIColor { get }
    var instructionFont: UIFont { get }
    var instructionColor: UIColor { get }
    var doneButtonFont: UIFont { get }
    var doneButtonColor: UIColor { get }
    var borderWidth: CGFloat { get }
    var borderColor: UIColor { get }
    var toolBarStyle: UIBarStyle { get }
    var toolBarTintColor: UIColor { get }
    var isToolBarTranslucent: Bool { get }
    var isOverlayVisible: Bool { get }
    var calendarButtonImage: UIImage { get }
    var calendarButtonStyle: ButtonStyle { get }
    var textFieldTintColor: UIColor { get }
    var displayFormat: String { get }
}
