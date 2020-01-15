//
//  SquareCollectionViewCellViewModel.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 30/12/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import ONECore

class SquareCollectionViewCellViewModel {
    var id: String = DefaultValue.emptyString
    var title: String = DefaultValue.emptyString
    var imageLink: String = DefaultValue.emptyString
    var didSelectAction: CollectionViewCellSelectionHandler?
}
