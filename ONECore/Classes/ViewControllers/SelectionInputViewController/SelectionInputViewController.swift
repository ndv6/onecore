//
//  SelectionInputViewController.swift
//  Kelolala
//
//  Created by Sofyan Fradenza Adi on 20/05/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import UIKit

public typealias OptionsSelectionHandler = (_ options: [Option]) -> Void

open class SelectionInputViewController: TableViewController {
    override open var closeButtonPosition: LayoutPosition { get { return .left } }
    open var doneButtonTitle: String { get { return DefaultValue.emptyString } }
    open var doneButtonStyleAttributes: [NSAttributedString.Key: Any]? {
        get { return nil }
    }
    open var separatorInset: UIEdgeInsets { get {
        return UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0
        )
    }}
    private var temporarySelectedOptions: [Option] = [Option]()
    public var selectedOptions: [Option] = [Option]()
    public var options: [Option] = [Option]()
    public var screenTitle: String = DefaultValue.emptyString
    public var didSelectAction: OptionsSelectionHandler?

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if didLoadData {
            rerender()
        } else {
            contentView.tableView.register(
                SelectionInputItemCell.self,
                forCellReuseIdentifier: SelectionInputItemCell.className
            )
        }
        temporarySelectedOptions = selectedOptions
    }

    override open func load() {
        super.load()
        startLoading()
    }

    open override func closeButtonPressed() {
        temporarySelectedOptions = selectedOptions
        super.closeButtonPressed()
    }

    open override func rightBarButtonItems() -> [UIBarButtonItem] {
        if doneButtonTitle.isEmpty { return [UIBarButtonItem]() }
        let button = UIBarButtonItem(
            title: doneButtonTitle,
            style: .done,
            target: self,
            action: #selector(doneButtonPressed)
        )
        button.setTitleTextAttributes(doneButtonStyleAttributes, for: .normal)
        button.setTitleTextAttributes(doneButtonStyleAttributes, for: .highlighted)
        return [button]
    }

    open func createItemCell(_ option: Option) -> SelectionInputItemCell {
        return contentView.tableView.dequeueReusableCell(withIdentifier: SelectionInputItemCell.className) as? SelectionInputItemCell ?? SelectionInputItemCell()
    }

    open func createHeaderSection(_ title: String) -> TableViewSection {
        return TableViewSection([])
    }

    private func renderHeaderSection() {
        contentView.appendSection(createHeaderSection(screenTitle))
    }

    private func renderOptionsSection() {
        let section = TableViewSection()
        for option in options {
            let cell = createItemCell(option)
            cell.didSelectAction = didSelectCell
            cell.render(option: option, isChecked: temporarySelectedOptions.contains(option))
            section.appendRow(cell)
        }
        contentView.appendSection(section)
    }

    open override func render() {
        super.render()
        renderHeaderSection()
        renderOptionsSection()
        contentView.setTableViewSeparator(
            show: true,
            separatorColor: UITableView().separatorColor,
            separatorStyle: .singleLine,
            separatorInset: separatorInset
        )
    }

    open func didSelectCell(_ cell: TableViewCell) {
        guard let cell = cell as? SelectionInputItemCell else { return }
        if cell.isChecked {
            temporarySelectedOptions.append(cell.option)
        } else {
            temporarySelectedOptions.remove(cell.option)
        }
    }

    open func resetSelection() {
        selectedOptions = [Option]()
        temporarySelectedOptions = selectedOptions
    }

    @objc private func doneButtonPressed() {
        selectedOptions = temporarySelectedOptions
        if let action: OptionsSelectionHandler = didSelectAction {
            action(selectedOptions)
        }
        self.dismiss(animated: true, completion: nil)
    }
}
