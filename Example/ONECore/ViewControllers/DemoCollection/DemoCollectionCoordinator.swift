//
//  DemoCollectionCoordinator.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 26/12/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import ONECore

class DemoCollectionCoordinator: Coordinator {
    private var presenter: NavigationController
    private let controller: DemoCollectionViewController
    private var alertCoordinator: AlertCoordinator?

    init(presenter: NavigationController) {
        self.presenter = presenter
        self.controller = DemoCollectionViewController()
        self.controller.title = R.string.localizable.menuTitleCollectionView()
        self.controller.demoCollectionViewModel = DemoCollectionCoordinator.demoCollectionViewModel
        self.controller.foodCollectionCellViewModel = DemoCollectionCoordinator.foodCollectionCellViewModel
        self.controller.drinkCollectionCellViewModel = DemoCollectionCoordinator.drinkCollectionCellViewModel
        self.controller.snackCollectionCellViewModel = DemoCollectionCoordinator.snackCollectionCellViewModel
        self.controller.placeCollectionCellViewModel = DemoCollectionCoordinator.placeCollectionCellViewModel
    }

    func start() {
        controller.delegate = self
        presenter.pushViewController(controller, animated: true)
    }
}

extension DemoCollectionCoordinator {
    private static var demoCollectionViewModel: DemoCollectionViewModel {
        return DemoCollectionViewModel()
    }

    private static var foodCollectionCellViewModel: FoodSquareCollectionCellViewModel {
        let foodCollectionViewViewModel = SquareCollectionViewViewModel(isLoading: true)
        let viewModel = FoodSquareCollectionCellViewModel(
            service: Service(baseUrl: APIConfig.baseUrl),
            collectionViewViewModel: foodCollectionViewViewModel
        )
        viewModel.title = R.string.localizable.sectionTitleBreakfastCollection()
        viewModel.rightButtonTitle = R.string.localizable.buttonSeeAll()
        return viewModel
    }

    private static var drinkCollectionCellViewModel: DrinkSquareCollectionCellViewModel {
        let drinkCollectionViewViewModel = SquareCollectionViewViewModel(isLoading: true)
        let viewModel = DrinkSquareCollectionCellViewModel(
            service: Service(baseUrl: APIConfig.baseUrl),
            collectionViewViewModel: drinkCollectionViewViewModel
        )
        viewModel.title = R.string.localizable.sectionTitleDrinkCollection()
        viewModel.rightButtonTitle = R.string.localizable.buttonSeeAll()
        return viewModel
    }

    private static var snackCollectionCellViewModel: SnackSquareCollectionCellViewModel {
        let snackCollectionViewViewModel = SquareCollectionViewViewModel(isLoading: true)
        let viewModel = SnackSquareCollectionCellViewModel(
            service: Service(baseUrl: APIConfig.baseUrl),
            collectionViewViewModel: snackCollectionViewViewModel
        )
        viewModel.title = R.string.localizable.sectionTitleSnackCollection()
        viewModel.rightButtonTitle = R.string.localizable.buttonSeeAll()
        return viewModel
    }

    private static var placeCollectionCellViewModel: PlaceSquareCollectionCellViewModel {
        let placeCollectionViewViewModel = SquareCollectionViewViewModel(isLoading: true)
        let viewModel = PlaceSquareCollectionCellViewModel(
            service: Service(baseUrl: APIConfig.baseUrl),
            collectionViewViewModel: placeCollectionViewViewModel
        )
        viewModel.title = R.string.localizable.sectionTitlePlaceCollection()
        viewModel.rightButtonTitle = R.string.localizable.buttonSeeAll()
        return viewModel
    }
}

extension DemoCollectionCoordinator: DemoCollectionViewControllerDelegate {
    func demoCollectionViewControllerDidReceivedError(error: ErrorResponse) {
        alertCoordinator = AlertCoordinator(
            presenter: presenter,
            title: error.code,
            message: error.message
        )
        alertCoordinator?.start()
    }

    func demoCollectionViewControllerDidSelectedFood(food: Food) {
        alertCoordinator = AlertCoordinator(presenter: presenter, message: food.title)
        alertCoordinator?.start()
    }

    func demoCollectionViewControllerDidSelectedDrink(drink: Drink) {
        alertCoordinator = AlertCoordinator(presenter: presenter, message: drink.title)
        alertCoordinator?.start()
    }

    func demoCollectionViewControllerDidSelectedSnack(snack: Snack) {
        alertCoordinator = AlertCoordinator(presenter: presenter, message: snack.title)
        alertCoordinator?.start()
    }

    func demoCollectionViewControllerDidSelectedPlace(place: Place) {
        alertCoordinator = AlertCoordinator(presenter: presenter, message: place.title)
        alertCoordinator?.start()
    }
}
