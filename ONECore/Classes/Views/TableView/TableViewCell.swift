//
//  TableViewCell.swift
//  ONECore
//
//  Created by DENZA on 07/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

public typealias CellSelectionHandler = (_ cell: TableViewCell) -> Void

open class TableViewCell: UITableViewCell {
    public var didSelectAction: CellSelectionHandler?

    override open func awakeFromNib() {
        super.awakeFromNib()
    }

    open func loadView() {
        self.selectionStyle = .none
        self.contentView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.clear
    }

    open func onSelected() {
        guard let didSelectAction = didSelectAction else { return }
        didSelectAction(self)
    }
}
