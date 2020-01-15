//
//  SquareCollectionCellViewModel.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 30/12/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import ONECore

protocol SquareCollectionCellViewModel {
    var title: String { get set }
    var rightButtonTitle: String { get set }
    var squareCollectionViewViewModel: SquareCollectionViewViewModel { get set }
}
