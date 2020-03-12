//
//  CheckboxStyle.swift
//  ONECore
//
//  Created by DENZA on 05/10/19.
//

import Foundation

public enum CheckboxVerticalPosition {
    case top
    case center
}

public enum CheckboxInteractionArea {
    case checkboxOnly
    case allArea
}

public protocol CheckboxStyle {
    var checkboxSize: CGFloat { get }
    var checkboxVerticalPosition: CheckboxVerticalPosition { get }
    var interactionArea: CheckboxInteractionArea { get }
    var spacing: CGFloat { get }
    var font: UIFont { get }
    var highlightedFont: UIFont { get }
    var textColor: UIColor { get }
    var highlightedTextColor: UIColor { get }
    var disabledColor: UIColor { get }
    var checkedImage: UIImage { get }
    var uncheckedImage: UIImage { get }
}
