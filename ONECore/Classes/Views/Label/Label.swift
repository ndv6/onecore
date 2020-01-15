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
}
