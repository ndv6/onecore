//
//  PlaceSquareCollectionCellViewModel.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 13/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import ONECore

class PlaceSquareCollectionCellViewModel: SquareCollectionCellViewModel {
    private var service: Service!
    var title: String = DefaultValue.emptyString
    var rightButtonTitle: String = DefaultValue.emptyString
    var didError: ((ErrorResponse) -> Void)?
    var didUpdate: ((PlaceSquareCollectionCellViewModel) -> Void)?
    var didSelectPlace: ((Place) -> Void)?
    var squareCollectionViewViewModel: SquareCollectionViewViewModel

    init(service: Service = Service(), collectionViewViewModel: SquareCollectionViewViewModel) {
        self.service = service
        self.squareCollectionViewViewModel = collectionViewViewModel
    }

    func load() {
        service.getPlaces(
            params: RequestGetPlaces(),
            success: { (data) in
                self.squareCollectionViewViewModel
                    .squareCollectionViewCellViewModels = data.places.map {
                        self.viewModelFor(place: $0)
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

    private func viewModelFor(place: Place) -> SquareCollectionViewCellViewModel {
        let viewModel = SquareCollectionViewCellViewModel(place: place)
        viewModel.didSelectAction = { [weak self] cell in
            self?.didSelectPlace?(place)
        }
        return viewModel
    }
}
