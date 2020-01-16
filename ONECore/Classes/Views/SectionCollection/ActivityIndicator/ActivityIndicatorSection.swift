//
//  ActivityIndicatorSection.swift
//  ONECore
//
//  Created by DENZA on 29/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

open class ActivityIndicatorSection: TableViewSection {
    private var cell: ActivityIndicatorCell!

    open func configure(contentView: TableView, style: UIActivityIndicatorView.Style) {
        if cell == nil {
            contentView.tableView.register(
                ActivityIndicatorCell.self,
                forCellReuseIdentifier: ActivityIndicatorCell.className
            )
        }
        cell = contentView.tableView.dequeueReusableCell(
            withIdentifier: ActivityIndicatorCell.className
        ) as? ActivityIndicatorCell ?? ActivityIndicatorCell()
        cell.setActivityIndicatorStyle(style)
        removeAllRows()
        appendRow(cell)
    }

    open func getCell() -> ActivityIndicatorCell {
        return cell
    }
}
