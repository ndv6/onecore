//
//  NestedTableView.swift
//  ONECore
//
//  Created by Sofyan Fradenza Adi on 23/07/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import UIKit

public protocol NestedTableViewDelegate: class {
    func nestedTableViewDidChangedLoading(_ isLoading: Bool)
    func nestedTableViewDidChangedState()
}

open class NestedTableView: TableView, TableViewContainerProtocol {
    private weak var nestedTableViewDelegate: NestedTableViewDelegate?
    private var isLoading: Bool = false
    open var isStartWithLoading: Bool { return false }
    open var sectionCollection: SectionCollection = SectionCollection()
    open func registerNibs() {}
    open func renderContent() {}

    convenience init() {
        self.init(frame: CGRect.zero)
        self.isLoading = isStartWithLoading
        commonInit(sender: self, isRender: false)
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.isScrollEnabled = false
    }

    open func configure(delegate: NestedTableViewDelegate?) {
        self.nestedTableViewDelegate = delegate
    }

    open func load() {
        startLoading()
    }

    public func startLoading() {
        isLoading = true
        nestedTableViewDelegate?.nestedTableViewDidChangedLoading(isLoading)
    }

    public func stopLoading() {
        isLoading = false
        nestedTableViewDelegate?.nestedTableViewDidChangedLoading(isLoading)
    }

    public func loading() -> Bool {
        return isLoading
    }

    open func renderLoadingState() {
        appendSection(sectionCollection.activityIndicator)
    }

    open func render() {
        removeAllSection()
        sectionCollection.configure(contentView: self)
        isLoading ? renderLoadingState() : renderContent()
        tableView.reloadData()
    }
}
