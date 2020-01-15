//
//  TableViewController.swift
//  ONECore
//
//  Created by DENZA on 07/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

open class TableViewController: ViewController, TableViewContainerProtocol {
    private var infiniteScroll: InfiniteScroll = InfiniteScroll()
    open var sectionCollection: SectionCollection = SectionCollection()
    open var contentView: TableView!
    open var pagination: Pagination = Pagination()
    lazy private var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(
            self,
            action: #selector(TableViewController.refreshHandler(_:)),
            for: UIControl.Event.valueChanged
        )
        refreshControl.tintColor = UIColor.white
        return refreshControl
    }()
    open var refreshControlTintColor: UIColor { get { return UIColor.white } }
    open var pullToRefreshEnabled: Bool { get { return false } }
    open var tableViewBackgroundColor: UIColor { get { return CoreStyle.Color.primaryBackground } }
    open var tableViewInset: UIEdgeInsets { get { return UIEdgeInsets.zero } }
    open func registerNibs() {}

    override open func viewDidLoad() {
        super.viewDidLoad()
        createContentView()
    }

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.renderTabBar()
            if CoreConfig.TableViewController.isAutoRenderOnEveryViewWillAppear {
                self.rerender()
            }
        }
    }

    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        resetCellSelection()
    }

    override open func load() {
        super.load()
        pagination.reset()
    }

    open func reloadTableView() {
        if pullToRefreshEnabled {
            contentView.tableView.reloadData()
            return
        }
        contentView.tableView.reloadDataWithoutScrollAnimation()
    }

    private func renderRefreshControl() {
        if pullToRefreshEnabled {
            refreshControl.tintColor = refreshControlTintColor
            contentView.tableView.addSubview(refreshControl)
        }
    }

    open func renderTabBar() {
        guard let navigation = navigationController else { return }
        guard let tbc = navigation.tabBarController else { return }
        tbc.setTabBarVisible(visible: navigation.viewControllers.first == self, animated: true)
    }

    open func createContentView() {
        var frame = UIScreen.main.bounds
        frame.size.height = SizeHelper.WindowHeight
        contentView = TableView(frame: frame, inset: tableViewInset)
        contentView.delegate = self
        contentView.commonInit(
            sender: self,
            isRender: !CoreConfig.TableViewController.isAutoRenderOnEveryViewWillAppear
        )
        renderRefreshControl()
        view.addSubview(contentView)
        setContentViewParentConstraint()
        configureBackgroundColor()
    }

    open func updateTableViewInset(_ inset: UIEdgeInsets) {
        if contentView == nil { return }
        contentView.createTableViewConstraint(inset: inset)
    }

    open func setContentViewParentConstraint() {
        contentView.setParentConstraint(parentView: view)
    }

    open func resetCellSelection() {
        if let indexPath = contentView.tableView.indexPathForSelectedRow {
            contentView.tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    open func render() {
        if contentView == nil { return }
        contentView.removeAllSection()
        sectionCollection.configure(contentView: contentView)
    }

    open func startLoading(withLightStyle: Bool = false) {
        contentView.removeAllSectionForLoadingPurpose()
        if withLightStyle {
            contentView.appendSection(sectionCollection.lightActivityIndicator)
        } else {
            contentView.appendSection(sectionCollection.activityIndicator)
        }
        reloadTableView()
    }

    open func stopLoading() {
        contentView.removeAllSection()
        render()
        reloadTableView()
    }

    open func createCellWithIdentifier(_ identifier: String) -> TableViewCell {
        return contentView.dequeueReusableCellWithIdentifier(nibName: identifier) as? TableViewCell ?? TableViewCell()
    }

    @objc open func refreshHandler(_ refreshControl: UIRefreshControl) {
        reload()
        refreshControl.endRefreshing()
    }

    @objc open func reload() {
        load()
        reloadTableView()
    }

    @objc open func rerender() {
        render()
        reloadTableView()
    }

    open func setInfiniteScrollEnabled(_ enabled: Bool = true) {
        infiniteScroll.isEnabled = enabled
    }

    open func setInfiniteScrollLoadingState(isLoading: Bool) {
        infiniteScroll.isLoading = isLoading
    }

    override open func configureBackgroundColor(_ color: UIColor? = nil) {
        super.configureBackgroundColor(color)
        let color = color == nil ? tableViewBackgroundColor : color
        contentView.tableView.backgroundColor = color
        if tableViewBackgroundColor != UIColor.clear {
            view.backgroundColor = color
            view.superview?.backgroundColor = color
        }
    }
}

extension TableViewController: TableViewDelegate {
    open func tableViewDidCommontInit(_ tableView: TableView) {}
    open func tableViewDidEndDecelerating(_ scrollView: UIScrollView) {}

    open func tableViewDidScroll(_ scrollView: UIScrollView) {
        if infiniteScroll.isEnabled {
            let contentOffset = scrollView.contentOffset.y
            let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
            if !infiniteScroll.isLoading && maximumOffset - contentOffset <= infiniteScroll.threshold {
                if !pagination.isLastPage() {
                    setInfiniteScrollLoadingState(isLoading: true)
                    loadMore()
                }
            }
        }
    }
}
