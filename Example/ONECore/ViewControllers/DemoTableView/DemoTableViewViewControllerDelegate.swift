//
//  DemoTableViewViewControllerDelegate.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 04/03/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

protocol DemoTableViewViewControllerDelegate: class {
    func demoTableViewViewControllerDidReceivedError(error: ErrorResponse)
    func demoTableViewViewControllerDidSelectedFood(food: Food)
}
