//
//  ActivityIndicatorCell.swift
//  ONECore
//
//  Created by DENZA on 29/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

open class ActivityIndicatorCell: TableViewCell {
    private var height = CGFloat(80)
    private var style: UIActivityIndicatorView.Style = .gray
    private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .gray)

    public func setHeight(_ height: CGFloat) {
        self.height = height
    }

    public func setActivityIndicatorStyle(_ style: UIActivityIndicatorView.Style) {
        self.style = style
    }

    override open func loadView() {
        super.loadView()
        setupRowHeight(height)
        createActivityIndicator()
    }

    private func setupRowHeight(_ height: CGFloat) {
        let container = UIView()
        container.frame.size.height = height
        contentView.addSubview(container)
        Constraint(parentView: contentView, childView: container).activate()
    }

    private func createActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: style)
        activityIndicator.hidesWhenStopped = true
        contentView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        activityIndicator.startAnimating()
    }
}
