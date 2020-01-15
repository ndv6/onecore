//
//  DemoCollectionViewController+Binding.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 14/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

extension DemoCollectionViewController {
    func bindToFoodCollectionCellViewModel() {
        guard let foodCollectionCellViewModel = foodCollectionCellViewModel else { return }
        foodCollectionCellViewModel.didUpdate = { [weak self] _ in
            DispatchQueue.main.async {
                self?.rerender()
            }
        }
        foodCollectionCellViewModel.didError = { [weak self] error in
            DispatchQueue.main.async {
                self?.delegate?.demoCollectionViewControllerDidReceivedError(error: error)
            }
        }
        foodCollectionCellViewModel.didSelectFood = { (food) in
            self.delegate?.demoCollectionViewControllerDidSelectedFood(food: food)
        }
    }

    func bindToDrinkCollectionCellViewModel() {
        guard let drinkCollectionCellViewModel = drinkCollectionCellViewModel else { return }
        drinkCollectionCellViewModel.didUpdate = { [weak self] _ in
            DispatchQueue.main.async {
                self?.rerender()
            }
        }
        drinkCollectionCellViewModel.didError = { [weak self] error in
            DispatchQueue.main.async {
                self?.delegate?.demoCollectionViewControllerDidReceivedError(error: error)
            }
        }
        drinkCollectionCellViewModel.didSelectDrink = { (drink) in
            self.delegate?.demoCollectionViewControllerDidSelectedDrink(drink: drink)
        }
    }

    func bindToSnackCollectionCellViewModel() {
        guard let snackCollectionCellViewModel = snackCollectionCellViewModel else { return }
        snackCollectionCellViewModel.didUpdate = { [weak self] _ in
            DispatchQueue.main.async {
                self?.rerender()
            }
        }
        snackCollectionCellViewModel.didError = { [weak self] error in
            DispatchQueue.main.async {
                self?.delegate?.demoCollectionViewControllerDidReceivedError(error: error)
            }
        }
        snackCollectionCellViewModel.didSelectSnack = { (snack) in
            self.delegate?.demoCollectionViewControllerDidSelectedSnack(snack: snack)
        }
    }

    func bindToPlaceCollectionCellViewModel() {
        guard let placeCollectionCellViewModel = placeCollectionCellViewModel else { return }
        placeCollectionCellViewModel.didUpdate = { [weak self] _ in
            DispatchQueue.main.async {
                self?.rerender()
            }
        }
        placeCollectionCellViewModel.didError = { [weak self] error in
            DispatchQueue.main.async {
                self?.delegate?.demoCollectionViewControllerDidReceivedError(error: error)
            }
        }
        placeCollectionCellViewModel.didSelectPlace = { (place) in
            self.delegate?.demoCollectionViewControllerDidSelectedPlace(place: place)
        }
    }
}
