//
//  SquareCollectionViewCellViewModel+Food.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 08/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

extension SquareCollectionViewCellViewModel {
    convenience init(food: Food) {
        self.init()
        self.id = food.id
        self.title = food.title
        self.imageLink = food.imageLink
    }
}
