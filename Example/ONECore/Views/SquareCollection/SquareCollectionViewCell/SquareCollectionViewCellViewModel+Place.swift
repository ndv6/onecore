//
//  SquareCollectionViewCellViewModel+Place.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 13/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

extension SquareCollectionViewCellViewModel {
    convenience init(place: Place) {
        self.init()
        self.id = place.id
        self.title = place.title
        self.imageLink = place.imageLink
    }
}
