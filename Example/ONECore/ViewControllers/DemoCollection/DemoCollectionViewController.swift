//
//  DemoCollectionViewController.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 26/12/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import ONECore

class DemoCollectionViewController: TableViewController {
    override var navigationBarStyle: UIBarStyle { return UIBarStyle.black }
    override var pullToRefreshEnabled: Bool { return true }
    override var refreshControlTintColor: UIColor { return Colors.primary }
    internal weak var delegate: DemoCollectionViewControllerDelegate?
    internal var demoCollectionViewModel: DemoCollectionViewModel?
    internal var foodCollectionCellViewModel: FoodSquareCollectionCellViewModel?
    internal var drinkCollectionCellViewModel: DrinkSquareCollectionCellViewModel?
    internal var snackCollectionCellViewModel: SnackSquareCollectionCellViewModel?
    internal var placeCollectionCellViewModel: PlaceSquareCollectionCellViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        bindToFoodCollectionCellViewModel()
        bindToDrinkCollectionCellViewModel()
        bindToSnackCollectionCellViewModel()
        bindToPlaceCollectionCellViewModel()
        contentView.setTableViewSeparator(
            show: true,
            separatorColor: Colors.separator,
            separatorStyle: UITableViewCell.SeparatorStyle.singleLine,
            separatorInset: UIEdgeInsets(
                top: DefaultValue.emptyCGFloat,
                left: SpaceSize.xSmall,
                bottom: DefaultValue.emptyCGFloat,
                right: DefaultValue.emptyCGFloat
            )
        )
    }

    override func load() {
        super.load()
        foodCollectionCellViewModel?.load()
        drinkCollectionCellViewModel?.load()
        snackCollectionCellViewModel?.load()
        placeCollectionCellViewModel?.load()
    }

    override func render() {
        super.render()
        let section = TableViewSection()
        renderSquareCollectionCellViewModel(foodCollectionCellViewModel, inSection: section)
        renderSquareCollectionCellViewModel(drinkCollectionCellViewModel, inSection: section)
        renderSquareCollectionCellViewModel(snackCollectionCellViewModel, inSection: section)
        renderSquareCollectionCellViewModel(placeCollectionCellViewModel, inSection: section)
        contentView.appendSection(section)
    }
}
