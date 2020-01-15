//
//  DropDownItemCell.swift
//  ONECore
//
//  Created by DENZA on 24/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

open class DropDownItemCell: TableViewCell {
    public var option: Option = Option()
    public var textFont: UIFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
    public var textActiveColor: UIColor = .black
    public var textInactiveColor: UIColor = .gray
    public var contentInset: UIEdgeInsets = UIEdgeInsets.zero
    private var mainLabel: Label = Label()
    private var descriptionLabel: Label = Label()
    private var containerWidth = DefaultValue.emptyCGFloat

    override open func awakeFromNib() {
        super.awakeFromNib()
        containerWidth = SizeHelper.ScreenWidth - (contentInset.left + contentInset.right)
    }

    private func renderMainLabel() {
        mainLabel.text = option.text
        mainLabel.textColor = option.isActive ? textActiveColor : textInactiveColor
        mainLabel.font = textFont
        mainLabel.numberOfLines = 0
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.textAlignment = .left
        mainLabel.frame.size.width = SizeHelper.getPercentValue(
            percent: option.description.isEmpty ? 100 : 54,
            valueOf: containerWidth
        )
        contentView.addSubview(mainLabel)
        Constraint(
            parentView: contentView,
            childView: mainLabel,
            leading: contentInset.left,
            trailing: contentInset.right + (containerWidth - mainLabel.frame.size.width),
            top: contentInset.top,
            bottom: contentInset.bottom
        ).activate()
    }

    private func renderDescriptionLabel() {
        descriptionLabel.text = option.description
        descriptionLabel.textColor = option.isActive
            ? textActiveColor.withAlphaComponent(0.5)
            : textInactiveColor
        descriptionLabel.font = textFont
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textAlignment = .right
        descriptionLabel.frame.size.width = SizeHelper.getPercentValue(
            percent: 45,
            valueOf: containerWidth
        )
        if !option.description.isEmpty {
            contentView.addSubview(descriptionLabel)
            Constraint(
                parentView: contentView,
                childView: descriptionLabel,
                leading: contentInset.left + (containerWidth - descriptionLabel.frame.size.width),
                trailing: contentInset.top,
                bottom: contentInset.bottom
            ).activate()
        }
    }

    public func setContent(leftText: String, rightText: String = DefaultValue.emptyString) {
        mainLabel.text = leftText
        descriptionLabel.text = rightText
    }

    open func renderContent() {
        contentView.removeAllSubviews()
        renderMainLabel()
        renderDescriptionLabel()
    }

    open func render() {
        isUserInteractionEnabled = option.isActive
        renderContent()
    }
}
