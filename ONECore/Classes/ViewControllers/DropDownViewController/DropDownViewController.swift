//
//  DropDownViewController.swift
//  ONECore
//
//  Created by DENZA on 23/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

public typealias OptionSelectionHandler = (_ option: Option) -> Void

open class DropDownViewController: FormTableViewController {
    public var selectedOption: Option = Option()
    public var options: [Option] = [Option]()
    public var didSelectAction: OptionSelectionHandler?
    public var textFont: UIFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
    public var textActiveColor: UIColor = .black
    public var textInactiveColor: UIColor = .gray
    public var separatorColor: UIColor = UITableView().separatorColor ?? .clear
    public var separatorInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    public var contentInset: UIEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    public var emptyTitle: String = DefaultValue.emptyString
    private var searchInputCell: UIView?
    private var searchKeyword: String = DefaultValue.emptyString
    open var searchEnabled: Bool { return false }

    override open func load() {
        super.load()
        startLoading()
    }

    open override func reload() {
        options.removeAll()
        super.reload()
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        contentView.tableView.register(
            DropDownItemCell.self,
            forCellReuseIdentifier: DropDownItemCell.className
        )
        contentView.tableView.register(
            EmptyItemCell.self,
            forCellReuseIdentifier: EmptyItemCell.className
        )
    }

    private func renderSearchInputCell() {
        if !searchEnabled || searchInputCell != nil { return }
        guard let searchInputCell = createSearchBarCell() else { return }
        searchInputCell.frame.size.width = contentView.bounds.width
        if let searchTextField = searchInputCell.getFirstTextField() {
            searchTextField.delegate = self
            searchTextField.returnKeyType = .search
            searchTextField.didChangeAction = didChangeSearchKeyword
        }
        setHeaderView(searchInputCell)
        self.searchInputCell = searchInputCell
    }

    override open func render() {
        super.render()
        if options.isEmpty {
            renderEmptyState()
            return
        }
        renderSearchInputCell()
        let section = TableViewSection()
        for option in options {
            if !searchKeyword.isEmpty
                && !option.text.lowercased().contains(searchKeyword.lowercased()) {
                continue
            }
            section.appendRow(createItemCell(option))
        }
        contentView.appendSection(section)
        contentView.setTableViewSeparator(
            show: true,
            separatorColor: separatorColor,
            separatorStyle: .singleLine,
            separatorInset: separatorInset
        )
    }

    open func renderEmptyState() {
        guard let cell = contentView.tableView.dequeueReusableCell(
            withIdentifier: EmptyItemCell.className
        ) as? EmptyItemCell else { return }
        cell.emptyTitle = emptyTitle
        cell.render()
        contentView.appendSection(TableViewSection(cell))
    }

    open func createItemCell(_ option: Option) -> DropDownItemCell {
        let cell = contentView.tableView.dequeueReusableCell(
            withIdentifier: DropDownItemCell.className
        ) as? DropDownItemCell ?? DropDownItemCell()
        cell.option = option
        cell.textFont = textFont
        cell.textActiveColor = textActiveColor
        cell.textInactiveColor = textInactiveColor
        cell.contentInset = contentInset
        cell.didSelectAction = didSelectCell
        cell.render()
        return cell
    }

    open func dismiss(with selectedOption: Option) {
        navigationController?.popViewController(animated: true)
    }

    open func didSelectCell(_ cell: TableViewCell) {
        guard let cell = cell as? DropDownItemCell else { return }
        if selectedOption.identifier != cell.option.identifier
            || selectedOption.text != cell.option.text {
            selectedOption = cell.option
        }
        if let action: OptionSelectionHandler = didSelectAction {
            action(selectedOption)
        }
        dismiss(with: selectedOption)
    }

    open func resetSelection() {
        selectedOption = Option()
    }

    open func createSearchBarCell() -> UIView? {
        return nil
    }

    open func didChangeSearchKeyword(_ input: InputProtocol, _ newValue: Any) {
        guard let newValue = newValue as? String else { return }
        search(keyword: newValue)
    }
}

extension DropDownViewController {
    override public func textFieldDidEndEditing(_ textField: UITextField) {
        super.textFieldDidEndEditing(textField)
        if let keyword = textField.text {
            search(keyword: keyword)
        }
    }

    private func search(keyword: String) {
        if !searchEnabled { return }
        searchKeyword = keyword
        rerender()
        contentView.scrollToTop()
    }
}
