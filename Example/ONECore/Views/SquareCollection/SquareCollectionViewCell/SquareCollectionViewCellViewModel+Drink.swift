//
//  SquareCollectionViewCellViewModel+Drink.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 13/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

extension SquareCollectionViewCellViewModel {
    convenience init(drink: Drink) {
        self.init()
        self.id = drink.id
        self.title = drink.title
        self.imageLink = drink.imageLink
    }
}
