//
//  SquareCollectionViewCell.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 30/12/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import ONECore

class SquareCollectionViewCell: CollectionViewCell {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.backgroundColor = .clear
        imageView.setRoundedCorners(radius: FrameSize.roundedCorners)
        imageView.backgroundColor = .groupTableViewBackground
        titleLabel.text = DefaultValue.emptyString
        titleLabel.textColor = Colors.primary
        titleLabel.font = UIFont.systemFont(ofSize: FontSize.paragraph2, weight: UIFont.Weight.semibold)
    }

    func render(viewModel: SquareCollectionViewCellViewModel) {
        identifier = viewModel.id
        titleLabel.text = viewModel.title
        imageView.downloadedFrom(link: viewModel.imageLink)
        didSelectAction = viewModel.didSelectAction
    }
}
