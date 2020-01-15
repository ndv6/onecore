//
//  InfiniteTableViewSection.swift
//  ONECore
//
//  Created by Sofyan Fradenza Adi on 13/12/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

open class InfiniteTableViewSection: TableViewSection {
    private var isLoading: Bool = false
    public var sender: TableViewController = TableViewController()

    open func configure(sender: TableViewController) {
        self.sender = sender
    }

    public func startLoading() {
        isLoading = true
    }

    public func stopLoading() {
        isLoading = false
    }

    open func render() {
        removeAllRows()
        if isLoading {
            appendRow(sender.sectionCollection.activityIndicator.getCell())
        } else {
            renderContent()
        }
    }

    open func renderContent() {}
}
