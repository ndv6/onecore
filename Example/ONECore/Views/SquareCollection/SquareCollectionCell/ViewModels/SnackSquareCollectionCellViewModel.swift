//
//  SnackSquareCollectionCellViewModel.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 13/01/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import ONECore

class SnackSquareCollectionCellViewModel: SquareCollectionCellViewModel {
    private var service: Service!
    var title: String = DefaultValue.emptyString
    var rightButtonTitle: String = DefaultValue.emptyString
    var didError: ((ErrorResponse) -> Void)?
    var didUpdate: ((SnackSquareCollectionCellViewModel) -> Void)?
    var didSelectSnack: ((Snack) -> Void)?
    var squareCollectionViewViewModel: SquareCollectionViewViewModel

    init(service: Service = Service(), collectionViewViewModel: SquareCollectionViewViewModel) {
        self.service = service
        self.squareCollectionViewViewModel = collectionViewViewModel
    }

    func load() {
        service.getSnacks(
            params: RequestGetSnacks(),
            success: { (data) in
                self.squareCollectionViewViewModel
                    .squareCollectionViewCellViewModels = data.snacks.map {
                        self.viewModelFor(snack: $0)
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

    private func viewModelFor(snack: Snack) -> SquareCollectionViewCellViewModel {
        let viewModel = SquareCollectionViewCellViewModel(snack: snack)
        viewModel.didSelectAction = { [weak self] cell in
            self?.didSelectSnack?(snack)
        }
        return viewModel
    }
}
