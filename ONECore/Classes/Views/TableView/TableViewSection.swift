//
//  TableViewSection.swift
//  ONECore
//
//  Created by DENZA on 07/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import Foundation

open class TableViewSection {
    private var cells: [TableViewCell] = [TableViewCell]()
    public var keepWhileLoading: Bool = false
    public var tag: Int = 0

    public init(_ cells: [TableViewCell] = [TableViewCell](), keepWhileLoading: Bool = false) {
        for cell in cells {
            appendRow(cell)
        }
        self.keepWhileLoading = keepWhileLoading
    }

    public init(_ cell: TableViewCell, keepWhileLoading: Bool = false) {
        appendRow(cell)
        self.keepWhileLoading = keepWhileLoading
    }

    public func numberOfRows() -> NSInteger {
        return cells.count
    }

    public func hasRowAtIndex(index: NSInteger) -> Bool {
        return index < cells.count
    }

    public func appendRow(_ cell: TableViewCell) {
        cells.append(cell)
    }

    public func appendRows(_ cells: [TableViewCell]) {
        for cell in cells {
            appendRow(cell)
        }
    }

    public func hasCell(_ cell: TableViewCell) -> Bool {
        return cells.contains(cell)
    }

    public func indexOfCell(cell: TableViewCell) -> NSInteger {
        if cells.isEmpty { return DefaultValue.emptyIndex }
        for index in 0...(cells.count - 1) where cells[index] == cell {
            return index
        }
        return DefaultValue.emptyIndex
    }

    public func removeAllRows() {
        cells.removeAll()
    }

    public func getRowAtIndex(index: NSInteger) -> TableViewCell {
        if hasRowAtIndex(index: index) {
            return cells[index]
        }
        return TableViewCell()
    }

    public func getRows() -> [TableViewCell] {
        return cells
    }
}
