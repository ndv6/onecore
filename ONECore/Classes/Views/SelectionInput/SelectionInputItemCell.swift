//
//  SelectionInputItemCell.swift
//  Kelolala
//
//  Created by Sofyan Fradenza Adi on 21/05/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import UIKit

open class SelectionInputItemCell: TableViewCell {
    public var option: Option = Option()
    public var isChecked: Bool = false
    open func renderContent() {}
    open func renderCheckmark() {}

    open func render(option: Option, isChecked: Bool = false) {
        self.option = option
        self.isChecked = isChecked
        isUserInteractionEnabled = self.option.isActive
        renderContent()
        renderCheckmark()
    }

    open override func onSelected() {
        isChecked = !isChecked
        renderCheckmark()
        super.onSelected()
    }
}
