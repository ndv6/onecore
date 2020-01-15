//
//  IsolateTableViewSection.swift
//  ONECore
//
//  Created by Sofyan Fradenza Adi on 17/12/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

open class IsolateTableViewSection: TableViewSection {
    public var sender: TableViewController = TableViewController()

    public init(sender: TableViewController) {
        super.init()
        self.sender = sender
    }
}
