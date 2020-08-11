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
    private var layoutConstraints: [NSLayoutConstraint] = [NSLayoutConstraint]()
    private var footerViewHeightConstraint: NSLayoutConstraint = NSLayoutConstraint()
    open var sectionCollection: SectionCollection = SectionCollection()
    open var headerView: UIView = UIView()
    open var footerView: UIView = UIView()
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
    open var refreshControlTintColor: UIColor { return UIColor.white }
    open var pullToRefreshEnabled: Bool { return false }
    open var tableViewBackgroundColor: UIColor { return CoreStyle.Color.primaryBackground }
    open var tableViewInset: UIEdgeInsets { return UIEdgeInsets.zero }
    open func registerNibs() {}
    open func setupViewModel() {}

    override open func viewDidLoad() {
        super.viewDidLoad()
        createHeaderView()
        createFooterView()
        createContentView()
        setupConstraint()
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
        CoreConfig.TableViewController.isReloadDataWithoutScrollAnimation
            ? contentView.tableView.reloadDataWithoutScrollAnimation()
            : contentView.tableView.reloadData()
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

    open func createHeaderView() {
        headerView = UIView()
        headerView.backgroundColor = .clear
        view.addSubview(headerView)
    }

    open func createFooterView() {
        footerView = UIView()
        footerView.backgroundColor = .clear
        view.addSubview(footerView)
    }

    open func createContentView() {
        contentView = TableView()
        contentView.delegate = self
        contentView.commonInit(
            sender: self,
            isRender: !CoreConfig.TableViewController.isAutoRenderOnEveryViewWillAppear
        )
        renderRefreshControl()
        view.addSubview(contentView)
        configureBackgroundColor()
    }

    open func resetCellSelection() {
        if let indexPath = contentView.tableView.indexPathForSelectedRow {
            contentView.tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    open func render() {
        if contentView == nil { return }
        setupViewModel()
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

    open func setHeaderView(_ view: UIView) {
        headerView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            view.topAnchor.constraint(equalTo: headerView.topAnchor),
            view.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
        ])
    }

    open func setFooterView(_ view: UIView) {
        footerView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: footerView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: footerView.trailingAnchor),
            view.topAnchor.constraint(equalTo: footerView.topAnchor),
            view.bottomAnchor.constraint(equalTo: footerView.bottomAnchor)
        ])
        footerViewHeightConstraint.isActive = false
    }

    open func setupConstraint(inset: UIEdgeInsets = UIEdgeInsets.zero) {
        if contentView == nil { return }
        NSLayoutConstraint.deactivate(layoutConstraints)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        footerView.translatesAutoresizingMaskIntoConstraints = false
        footerViewHeightConstraint = footerView.heightAnchor.constraint(
            equalToConstant: DefaultValue.emptyCGFloat
        )
        layoutConstraints = [
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: inset.left
            ),
            contentView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: inset.right * -1
            ),
            contentView.topAnchor.constraint(
                equalTo: headerView.bottomAnchor,
                constant: inset.top
            ),
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footerView.topAnchor.constraint(equalTo: contentView.bottomAnchor),
            footerView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: inset.bottom * -1
            ),
            footerViewHeightConstraint
        ]
        NSLayoutConstraint.activate(layoutConstraints)
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
