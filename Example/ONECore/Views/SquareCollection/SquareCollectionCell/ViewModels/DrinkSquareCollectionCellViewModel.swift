//
//  DrinkSquareCollectionCellViewModel.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 10/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import ONECore

class DrinkSquareCollectionCellViewModel: SquareCollectionCellViewModel {
    private var service: Service!
    var title: String = DefaultValue.emptyString
    var rightButtonTitle: String = DefaultValue.emptyString
    var didError: ((ErrorResponse) -> Void)?
    var didUpdate: ((DrinkSquareCollectionCellViewModel) -> Void)?
    var didSelectDrink: ((Drink) -> Void)?
    var squareCollectionViewViewModel: SquareCollectionViewViewModel

    init(service: Service = Service(), collectionViewViewModel: SquareCollectionViewViewModel) {
        self.service = service
        self.squareCollectionViewViewModel = collectionViewViewModel
    }

    func load() {
        service.getDrinks(
            params: RequestGetDrinks(),
            success: { (data) in
                self.squareCollectionViewViewModel
                    .squareCollectionViewCellViewModels = data.drinks.map {
                        self.viewModelFor(drink: $0)
                }
            },
            failed: { (error) in
                self.squareCollectionViewViewModel
                    .squareCollectionViewCellViewModels
                    .removeAll()
                self.didError?(error)
            },
            completion: {
                self.squareCollectionViewViewModel.isLoading = false
                self.didUpdate?(self)
            }
        )
    }

    private func viewModelFor(drink: Drink) -> SquareCollectionViewCellViewModel {
        let viewModel = SquareCollectionViewCellViewModel(drink: drink)
        viewModel.didSelectAction = { [weak self] cell in
            self?.didSelectDrink?(drink)
        }
        return viewModel
    }
}
