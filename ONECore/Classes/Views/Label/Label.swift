//
//  Label.swift
//  ONECore
//
//  Created by DENZA on 08/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

open class Label: UILabel {
    public var style: LabelStyle! {
        didSet {
            applyStyle()
        }
    }

    private func applyStyle() {
        font = style.textFont
        textColor = style.textColor
        textAlignment = style.alignment
    }

    public func setTextWithPartialHighlight(
        fullText: String,
        highlightText: String = DefaultValue.emptyString,
        highlightFont: UIFont,
        highlightColor: UIColor? = nil
    ) {
        let attribute = NSMutableAttributedString(string: fullText)
        let highlightRange = NSRange(
            location: fullText.count - highlightText.count,
            length: highlightText.count
        )
        attribute.addAttribute(
            NSAttributedString.Key.font,
            value: highlightFont,
            range: highlightRange
        )
        attribute.addAttribute(
            NSAttributedString.Key.foregroundColor,
            value: highlightColor ?? UIColor.black,
            range: NSRange(location: 0, length: fullText.count)
        )
        attribute.addAttribute(
            NSAttributedString.Key.foregroundColor,
            value: highlightColor ?? UIColor.black,
            range: highlightRange
        )
        self.attributedText = attribute
    }
}
