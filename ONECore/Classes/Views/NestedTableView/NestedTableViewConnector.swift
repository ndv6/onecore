//
//  NestedTableViewConnector.swift
//  ONECore
//
//  Created by Sofyan Fradenza Adi on 01/08/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import UIKit

open class NestedTableViewConnector: NSObject {
    open var contentView: NestedTableView { return NestedTableView() }
    private var cell: NestedTableViewContainerCell?
    private var isEmptyContent: Bool = true

    public func isEmpty() -> Bool {
        return isEmptyContent
    }

    open func render(
        containerCell: NestedTableViewContainerCell,
        containerTableView: TableView,
        minimumContentHeight: CGFloat = 0,
        delegate: NestedTableViewDelegate?
    ) {
        if cell == nil {
            cell = containerCell
            contentView.configure(delegate: delegate)
        }
        guard let cell = cell else {
            isEmptyContent = true
            return
        }
        contentView.render()
        cell.nestedTableViewContainer.setContentView(
            contentView: contentView,
            minimumContentHeight: minimumContentHeight
        )
        cell.nestedTableViewContainer.setupConstraint()
        isEmptyContent = contentView.isEmpty()
        return
    }

    public func getCell() -> NestedTableViewContainerCell? {
        return cell
    }
}
