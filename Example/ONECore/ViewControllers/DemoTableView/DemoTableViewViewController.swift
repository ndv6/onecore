//
//  DemoTableViewViewController.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 04/03/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import ONECore

class DemoTableViewViewController: TableViewController {
    override var navigationBarStyle: UIBarStyle { return UIBarStyle.black }
    override var pullToRefreshEnabled: Bool { return true }
    internal weak var delegate: DemoTableViewViewControllerDelegate?

    private func renderSearchBar() {
        guard let cell: TextFieldCell = contentView.dequeueReusableNibCell(
            nibClass: TextFieldCell.self
        ) as? TextFieldCell else { return }
        cell.setTitle("Pencarian")
        cell.setPlaceholder("Ketik kata pencarian")
        contentView.appendSection(TableViewSection(cell))
    }

    override func render() {
        super.render()
        renderSearchBar()
    }
}

