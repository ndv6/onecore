//
//  EmptySection.swift
//  DLRadioButton
//
//  Created by DENZA on 13/03/19.
//

import UIKit

open class EmptySection: TableViewSection {
    private var cell: EmptyCell!

    open func configure(contentView: TableView, height: CGFloat) {
        if cell == nil {
            contentView.tableView.register(EmptyCell.self, forCellReuseIdentifier: EmptyCell.className)
            cell = contentView.tableView.dequeueReusableCell(
                withIdentifier: EmptyCell.className
            ) as? EmptyCell ?? EmptyCell()
            cell.setHeight(height)
        }
        removeAllRows()
        appendRow(cell)
    }

    open func getCell() -> EmptyCell {
        return cell
    }
}
