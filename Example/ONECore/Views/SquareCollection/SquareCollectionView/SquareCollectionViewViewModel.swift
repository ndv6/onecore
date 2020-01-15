//
//  SquareCollectionViewViewModel.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 07/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import ONECore

class SquareCollectionViewViewModel {
    var squareCollectionViewCellViewModels = [SquareCollectionViewCellViewModel]()
    var isLoading: Bool = false

    init(isLoading: Bool = false) {
        self.isLoading = isLoading
    }
}
