//
//  SquareCollectionViewCellViewModel+Snack.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 13/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

extension SquareCollectionViewCellViewModel {
    convenience init(snack: Snack) {
        self.init()
        self.id = snack.id
        self.title = snack.title
        self.imageLink = snack.imageLink
    }
}
