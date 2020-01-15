//
//  MenuItemViewModel.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 26/12/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import ONECore

class MenuItemViewModel: NSObject {
    public var title: String = DefaultValue.emptyString
    public var destinationCoordinator: Coordinator?

    init(title: String = DefaultValue.emptyString, destinationCoordinator: Coordinator? = nil) {
        self.title = title
        self.destinationCoordinator = destinationCoordinator
    }
}
