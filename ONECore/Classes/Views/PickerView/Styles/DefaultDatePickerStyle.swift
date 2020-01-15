//
//  DefaultDatePickerStyle.swift
//  Alamofire
//
//  Created by ALDO LAZUARDI on 01/10/19.
//

import UIKit

open class DefaultDatePickerStyle: DatePickerStyle {
    open var backgroundColor: UIColor = .white
    open var instructionFont: UIFont = UIFont.systemFont(ofSize: UIFont.labelFontSize)
    open var instructionColor: UIColor = UIColor.darkText
    open var doneButtonFont: UIFont = UIFont.systemFont(ofSize: UIFont.buttonFontSize)
    open var doneButtonColor: UIColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0)
    open var borderWidth: CGFloat = 0
    open var borderColor: UIColor = .clear
    open var toolBarStyle: UIBarStyle = .default
    open var toolBarTintColor: UIColor = .clear
    open var isToolBarTranslucent: Bool = false
    open var isOverlayVisible: Bool = false
    open var calendarButtonImage: UIImage = CoreStyle.Image.calendarPicker
    open var calendarButtonStyle: ButtonStyle = DefaultButtonStyle()
    open var textFieldTintColor: UIColor = .clear
    open var displayFormat: String = DateFormat.date
    public init() {}
}
