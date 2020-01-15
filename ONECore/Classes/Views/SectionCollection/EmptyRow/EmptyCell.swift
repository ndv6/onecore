//
//  EmptyCell.swift
//  DLRadioButton
//
//  Created by DENZA on 13/03/19.
//

import UIKit

open class EmptyCell: TableViewCell {
    private var height = CGFloat(0)

    public func setHeight(_ height: CGFloat) {
        self.height = height
    }

    override open func loadView() {
        super.loadView()
        setupRowHeight(height)
    }

    private func setupRowHeight(_ height: CGFloat) {
        let container = UIView()
        container.frame.size.height = height
        contentView.addSubview(container)
        Constraint(parentView: contentView, childView: container).activate()
    }
}
