//
//  NestedTableViewContainerCell.swift
//  ONECore
//
//  Created by Sofyan Fradenza Adi on 02/08/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import Foundation

open class NestedTableViewContainerCell: TableViewCell {
    open var nestedTableViewContainer: NestedTableViewContainer {
        get { return NestedTableViewContainer() }
        set {}
    }
}
