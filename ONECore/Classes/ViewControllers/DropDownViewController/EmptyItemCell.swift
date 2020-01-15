//
//  EmptyItemCell.swift
//  Alamofire
//
//  Created by Aldo on 18/11/19.
//

import UIKit

open class EmptyItemCell: TableViewCell {
    public var textFont: UIFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
    public var textItemColor: UIColor = .gray
    public var contentInset: UIEdgeInsets = UIEdgeInsets.zero
    public var emptyTitle: String = DefaultValue.emptyString
    private var mainLabel: Label = Label()
    private var containerWidth = DefaultValue.emptyCGFloat

    override open func awakeFromNib() {
        super.awakeFromNib()
        containerWidth = SizeHelper.ScreenWidth - (contentInset.left + contentInset.right)
    }

    private func renderMainLabel() {
        mainLabel.text = emptyTitle
        mainLabel.textColor = textItemColor
        mainLabel.font = textFont
        mainLabel.numberOfLines = 0
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.textAlignment = .center
        mainLabel.frame.size.width = containerWidth
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

    open func renderContent() {
        contentView.removeAllSubviews()
        renderMainLabel()
    }

    open func render() {
        isUserInteractionEnabled = false
        renderContent()
    }
}
