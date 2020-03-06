//
//  TableView.swift
//  ONECore
//
//  Created by DENZA on 07/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

@objc public protocol TableViewDelegate {
    @objc optional func tableViewDidCommontInit(_ tableView: TableView)
    @objc optional func tableViewDidScroll(_ scrollView: UIScrollView)
    @objc optional func tableViewDidEndDecelerating(_ scrollView: UIScrollView)
}

open class TableView: View {
    private var sections: [TableViewSection] = [TableViewSection]()
    private var tableViewConstraint: Constraint!
    private var tableViewInset: UIEdgeInsets = UIEdgeInsets.zero
    public weak var delegate: TableViewDelegate?
    public var tableView: UITableView!
    public var registeredCellIdentifiers: [String] = [String]()

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
    }

    public convenience init(frame: CGRect, inset: UIEdgeInsets = UIEdgeInsets.zero) {
        self.init(frame: frame)
        self.tableViewInset = inset
    }

    open func commonInit(sender: TableViewContainerProtocol, isRender: Bool = true) {
        sender.registerNibs()
        createTableView()
        configureTableView()
        registerCellIdentifiers()
        if isRender {
            sender.render()
        }
        delegate?.tableViewDidCommontInit?(self)
        self.backgroundColor = .clear
    }

    private func createTableView() {
        if tableView != nil && tableView.superview != nil {
            tableView.removeFromSuperview()
        }
        tableView = UITableView(frame: self.bounds, style: UITableView.Style.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        addSubview(tableView)
        createTableViewConstraint(inset: tableViewInset)
    }

    private func registerCellIdentifiers() {
        for cellIdentifier in registeredCellIdentifiers {
            let nib = UINib(nibName: cellIdentifier, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        }
    }

    private func resetTableViewConstraint() {
        if tableViewConstraint != nil {
            self.removeConstraint(tableViewConstraint.leading)
            self.removeConstraint(tableViewConstraint.trailing)
            self.removeConstraint(tableViewConstraint.top)
            self.removeConstraint(tableViewConstraint.bottom)
        }
    }

    open func createTableViewConstraint(inset: UIEdgeInsets) {
        resetTableViewConstraint()
        tableViewConstraint = Constraint(parentView: self, childView: tableView)
        tableViewConstraint.leading.constant = inset.left
        tableViewConstraint.trailing.constant = inset.right
        tableViewConstraint.top.constant = inset.top
        tableViewConstraint.bottom.constant = inset.bottom
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(tableViewConstraint.leading)
        self.addConstraint(tableViewConstraint.trailing)
        self.addConstraint(tableViewConstraint.top)
        self.addConstraint(tableViewConstraint.bottom)
        tableViewConstraint.activate()
    }

    open func configureTableView() {
        tableView.delegate = self
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.separatorColor = UIColor.black
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.white
        tableView.contentInset = UIEdgeInsets.zero
        if #available(iOS 9.0, *) {
            tableView.cellLayoutMarginsFollowReadableWidth = false
        }
    }

    open func setTableViewSeparator(
        show: Bool,
        separatorColor: UIColor?,
        separatorStyle: UITableViewCell.SeparatorStyle?,
        separatorInset: UIEdgeInsets?
    ) {
        if !show {
            tableView.separatorStyle = .none
            return
        }
        if let separatorColor = separatorColor {
            tableView.separatorColor = separatorColor
        }
        if let separatorStyle = separatorStyle {
            tableView.separatorStyle = separatorStyle
        }
        if let separatorInset = separatorInset {
            tableView.separatorInset = separatorInset
        }
    }

    public func hasSectionAtIndex(index: NSInteger) -> Bool {
        return index < sections.count
    }

    public func hasIndexPath(indexPath: IndexPath) -> Bool {
        return hasSectionAtIndex(index: indexPath.section)
            && sections[indexPath.section].hasRowAtIndex(index: indexPath.row)
    }

    open func appendSection(_ section: TableViewSection) {
        section.tag = sections.count
        self.sections.append(section)
    }

    public func appendSections(_ sections: [TableViewSection]) {
        for section in sections {
            appendSection(section)
        }
    }

    public func removeAllSection() {
        sections.removeAll()
    }

    public func removeSection(at index: Int, with animation: UITableView.RowAnimation) {
        sections.remove(at: index)
        tableView.deleteSections([index], with: animation)
    }

    public func removeAllSectionForLoadingPurpose() {
        if sections.isEmpty { return }
        var placeholderSections = [TableViewSection]()
        for index in 0...(sections.count - 1) where sections[index].keepWhileLoading {
            placeholderSections.append(sections[index])
        }
        removeAllSection()
        sections = placeholderSections
    }

    public func hasCell(cell: TableViewCell) -> Bool {
        for section in sections {
            if section.hasCell(cell) {
                return true
            }
        }
        return false
    }

    public func indexPathOfCell(cell: TableViewCell) -> IndexPath {
        for section in 0...(sections.count - 1) {
            let row = sections[section].indexOfCell(cell: cell)
            if row >= 0 {
                return IndexPath(row: row, section: section)
            }
        }
        return IndexPath()
    }

    public func scrollTo(row: TableViewCell) {
        let indexPath = indexPathOfCell(cell: row)
        if indexPath.isEmpty { return }
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }

    public func scrollToVisible(row: TableViewCell) {
        guard let superview = row.superview else { return }
        let visibleRect = tableView.convert(row.frame, to: superview)
        tableView.scrollRectToVisible(visibleRect, animated: true)
    }

    public func dequeueReusableCellWithIdentifier(nibName: String) -> UITableViewCell {
        if let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: nibName) {
            return cell
        }
        return UITableViewCell()
    }

    public func registerNib<T>(nibClass: T.Type, resource: String? = nil) where T: TableViewCell {
        var bundle: Bundle?
        if let resource = resource {
            let nibBundle = Bundle(for: nibClass.self)
            guard let url = nibBundle.url(forResource: resource, withExtension: "bundle") else { return }
            bundle = Bundle(url: url)
        }
        let nib = UINib(nibName: nibClass.className, bundle: bundle)
        if registeredCellIdentifiers.contains(nibClass.className) { return }
        registeredCellIdentifiers.append(nibClass.className)
        tableView.register(nib, forCellReuseIdentifier: nibClass.className)
    }

    public func dequeueReusableNibCell<T>(
        nibClass: T.Type,
        resource: String? = nil
    ) -> UITableViewCell where T: TableViewCell {
        registerNib(nibClass: nibClass, resource: resource)
        if let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: nibClass.className) {
            return cell
        }
        return UITableViewCell()
    }

    public func reloadSection(_ section: TableViewSection) {
        tableView.reloadSections(
            IndexSet(integer: section.tag),
            with: UITableView.RowAnimation.automatic
        )
    }

    public func numberOfSections() -> Int {
        return sections.count
    }

    public func numberOfRows() -> Int {
        var total = 0
        for section in sections {
            total += section.numberOfRows()
        }
        return total
    }

    public func isEmpty() -> Bool {
        return numberOfRows() <= DefaultValue.emptyInt
    }

    public func scrollToTop() {
        tableView.setContentOffset(.zero, animated: true)
    }
}

extension TableView: UITableViewDelegate, UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if hasSectionAtIndex(index: section) {
            return sections[section].numberOfRows()
        }
        return 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if hasIndexPath(indexPath: indexPath) {
            let section = sections[indexPath.section]
            let cell = section.getRowAtIndex(index: indexPath.row)
            cell.drawSeparator(tableView: tableView, indexPath: indexPath, rowCount: section.numberOfRows())
            cell.loadView()
            return cell
        }
        return UITableViewCell()
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if hasIndexPath(indexPath: indexPath) {
            let row = sections[indexPath.section].getRowAtIndex(index: indexPath.row)
            row.onSelected()
        }
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }

    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }

    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

extension TableView: UIScrollViewDelegate {
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        tableView.endEditing(true)
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.tableViewDidScroll?(scrollView)
    }

    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegate?.tableViewDidEndDecelerating?(scrollView)
    }
}
