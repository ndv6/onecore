//
//  MenuItemCell.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 26/12/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import ONECore

class MenuItemCell: TableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.text = DefaultValue.emptyString
        titleLabel.font = UIFont.systemFont(ofSize: FontSize.paragraph1, weight: .regular)
    }

    func render(model: MenuItemViewModel) {
        titleLabel.text = model.title
    }
}
