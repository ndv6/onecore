//
//  DemoCollectionViewController+Render.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 14/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import ONECore

extension DemoCollectionViewController {
    func renderSquareCollectionCellViewModel(
        _ viewModel: SquareCollectionCellViewModel?,
        inSection section: TableViewSection
    ) {
        guard let viewModel = viewModel else { return }
        guard let cell = contentView.dequeueReusableNibCell(
            nibClass: SquareCollectionCell.self
        ) as? SquareCollectionCell else { return }
        cell.render(viewModel: viewModel)
        section.appendRow(cell)
    }
}
