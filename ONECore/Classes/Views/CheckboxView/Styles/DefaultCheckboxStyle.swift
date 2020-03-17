//
//  DefaultCheckboxStyle.swift
//  ONECore
//
//  Created by DENZA on 05/10/19.
//

import UIKit

open class DefaultCheckboxStyle: CheckboxStyle {
    open var checkboxSize = CGFloat(18)
    open var checkboxVerticalPosition = CheckboxVerticalPosition.top
    open var interactionArea = CheckboxInteractionArea.checkboxOnly
    open var spacing = CGFloat(16)
    open var font = UIFont.systemFont(ofSize: UIFont.labelFontSize)
    open var highlightedFont = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
    open var textColor = UIColor.black
    open var highlightedTextColor = UIColor.black
    open var disabledColor = UIColor.lightGray
    open var checkedImage = CoreStyle.Image.checkedBox
    open var uncheckedImage = CoreStyle.Image.uncheckedBox
    public init() {}
}
