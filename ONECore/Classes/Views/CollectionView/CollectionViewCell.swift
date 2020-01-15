//
//  CollectionViewCell.swift
//  ONECore
//
//  Created by Sofyan Fradenza Adi on 27/12/19.
//

import UIKit

public typealias CollectionViewCellSelectionHandler = (_ cell: CollectionViewCell) -> Void

open class CollectionViewCell: UICollectionViewCell {
    public var id: String = DefaultValue.emptyString
    public var didSelectAction: CollectionViewCellSelectionHandler?

    override open func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.clear
    }

    func onSelected(){
        guard let didSelectAction = didSelectAction else { return }
        didSelectAction(self)
    }
}
