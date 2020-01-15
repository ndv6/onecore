//
//  SquareCollectionView.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 07/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import ONECore

class SquareCollectionView: CollectionView {
    private let section = CollectionViewSection()

    override func awakeFromNib() {
        super.awakeFromNib()
        setLayout(
            itemSize: CGSize(width: FrameSize.squareCollectionItemWidth, height: bounds.height),
            minimumSpacing: SpaceSize.xSmall
        )
    }

    func render(viewModel: SquareCollectionViewViewModel) {
        super.render()
        section.removeAllItems()
        for viewModel in viewModel.squareCollectionViewCellViewModels {
            section.appendItem(viewModel)
        }
        appendSection(section)
        viewModel.isLoading ? startLoading() : stopLoading()
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = dequeueReusableNibCell(
            nibClass: SquareCollectionViewCell.self,
            indexPath: indexPath
        ) as? SquareCollectionViewCell else { return UICollectionViewCell() }
        if let viewModel = section.getItemAtIndex(indexPath.row) as? SquareCollectionViewCellViewModel {
            cell.render(viewModel: viewModel)
        }
        return cell
    }
}
