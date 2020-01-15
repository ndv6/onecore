//
//  SquareCollectionCell.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 30/12/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import ONECore

class SquareCollectionCell: TableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var rightButton: UIButton!
    @IBOutlet private weak var collectionView: SquareCollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = UIFont.boldSystemFont(ofSize: FontSize.headline4)
        titleLabel.text = DefaultValue.emptyString
        titleLabel.textColor = Colors.primary
        rightButton.titleLabel?.font = UIFont.systemFont(ofSize: FontSize.paragraph2)
        collectionView.backgroundColor = .clear
    }

    func render(viewModel: SquareCollectionCellViewModel) {
        titleLabel.text = viewModel.title
        rightButton.setTitle(viewModel.rightButtonTitle, for: .normal)
        collectionView.render(viewModel: viewModel.squareCollectionViewViewModel)
    }
}
