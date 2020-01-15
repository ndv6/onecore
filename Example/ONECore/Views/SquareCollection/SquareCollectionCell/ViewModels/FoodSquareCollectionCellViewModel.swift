//
//  FoodSquareCollectionCellViewModel.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 09/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import ONECore

class FoodSquareCollectionCellViewModel: SquareCollectionCellViewModel {
    private var service: Service!
    var title: String = DefaultValue.emptyString
    var rightButtonTitle: String = DefaultValue.emptyString
    var didError: ((ErrorResponse) -> Void)?
    var didUpdate: ((FoodSquareCollectionCellViewModel) -> Void)?
    var didSelectFood: ((Food) -> Void)?
    var squareCollectionViewViewModel: SquareCollectionViewViewModel

    init(service: Service = Service(), collectionViewViewModel: SquareCollectionViewViewModel) {
        self.service = service
        self.squareCollectionViewViewModel = collectionViewViewModel
    }

    func load() {
        service.getFoods(
            params: RequestGetFoods(),
            success: { (data) in
                self.squareCollectionViewViewModel
                    .squareCollectionViewCellViewModels = data.foods.map {
                        self.viewModelFor(food: $0)
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

    private func viewModelFor(food: Food) -> SquareCollectionViewCellViewModel {
        let viewModel = SquareCollectionViewCellViewModel(food: food)
        viewModel.didSelectAction = { [weak self] cell in
            self?.didSelectFood?(food)
        }
        return viewModel
    }
}
