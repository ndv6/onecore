//
//  DemoCollectionViewControllerDelegate.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 26/12/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

protocol DemoCollectionViewControllerDelegate: class {
    func demoCollectionViewControllerDidReceivedError(error: ErrorResponse)
    func demoCollectionViewControllerDidSelectedFood(food: Food)
    func demoCollectionViewControllerDidSelectedDrink(drink: Drink)
    func demoCollectionViewControllerDidSelectedSnack(snack: Snack)
    func demoCollectionViewControllerDidSelectedPlace(place: Place)
}
