//
//  MainMenuViewController.swift
//  ONECore
//
//  Created by fradenza on 03/12/2019.
//  Copyright (c) 2019 fradenza. All rights reserved.
//

import UIKit
import ONECore

class MainMenuViewController: TableViewController {
    override var navigationBarStyle: UIBarStyle { return UIBarStyle.black }
    internal var menus: [MenuItemViewModel] = [MenuItemViewModel]()
    internal weak var delegate: MainMenuViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = R.string.localizable.screenTitleMainMenu()
        contentView.setTableViewSeparator(
            show: true,
            separatorColor: UIColor.lightGray,
            separatorStyle: .singleLine,
            separatorInset: UIEdgeInsets(
                top: DefaultValue.emptyCGFloat,
                left: SpaceSize.xSmall,
                bottom: DefaultValue.emptyCGFloat,
                right: DefaultValue.emptyCGFloat
            )
        )
    }

    override func viewWillAppear(_ animated: Bool) {
        delegate?.mainMenuViewControllerWillAppear()
        super.viewWillAppear(animated)
    }

    private func renderMenu(menu: MenuItemViewModel, inSection section: TableViewSection) {
        guard let cell = contentView.dequeueReusableNibCell(
            nibClass: MenuItemCell.self
        ) as? MenuItemCell else { return }
        cell.render(model: menu)
        cell.didSelectAction = { (_ cell: TableViewCell) in
            self.delegate?.mainMenuViewControllerDidSelectMenu(menu)
        }
        section.appendRow(cell)
    }

    private func renderMenus() {
        let section = TableViewSection()
        for menu in menus {
            renderMenu(menu: menu, inSection: section)
        }
        contentView.appendSection(section)
    }

    override func render() {
        super.render()
        renderMenus()
    }
}
