//
//  CollectionView.swift
//  ONECore
//
//  Created by Sofyan Fradenza Adi on 27/12/19.
//

import UIKit

@objc public protocol CollectionViewDelegate {
    @objc optional func collectionViewDidScroll(_ scrollView: UIScrollView)
    @objc optional func collectionViewDidEndDecelerating(_ scrollView: UIScrollView)
}

open class CollectionView: View {
    private var sections: [CollectionViewSection] = [CollectionViewSection]()
    private var collectionViewConstraint: Constraint!
    private var collectionViewInset: UIEdgeInsets = UIEdgeInsets.zero
    private var registeredCellIdentifiers: [String] = [String]()
    private var activityIndicator = UIActivityIndicatorView()
    public weak var delegate: CollectionViewDelegate?
    public var collectionView: UICollectionView!
    public var pageControl: UIPageControl?

    open override func awakeFromNib() {
        super.awakeFromNib()
        createCollectionView()
        createActivityIndicator()
        configureCollectionView()
        stopLoading()
    }

    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let collectionView = collectionView else { return }
        collectionView.frame = bounds
    }

    private func createCollectionView() {
        if collectionView != nil && collectionView.superview != nil {
            collectionView.removeFromSuperview()
        }
        collectionView = UICollectionView(
            frame: self.bounds,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        addSubview(collectionView)
    }

    private func createActivityIndicator() {
        if activityIndicator.superview != nil {
            activityIndicator.removeFromSuperview()
        }
        activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.frame.origin = CGPoint(
            x: SizeHelper.getOriginXAlignCenter(
                width: activityIndicator.frame.size.width,
                containerWidth: bounds.width
            ),
            y: SizeHelper.getOriginYAlignCenter(
                height: activityIndicator.frame.size.height,
                containerHeight: bounds.height
            )
        )
        activityIndicator.hidesWhenStopped = true
        addSubview(activityIndicator)
    }

    private func resetTableViewConstraint() {
        if collectionViewConstraint != nil {
            self.removeConstraint(collectionViewConstraint.leading)
            self.removeConstraint(collectionViewConstraint.trailing)
            self.removeConstraint(collectionViewConstraint.top)
            self.removeConstraint(collectionViewConstraint.bottom)
        }
    }

    open func configureCollectionView() {
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets.zero
    }
    
    func renderPageControl() {
        guard let pageControl = pageControl else { return }
        pageControl.hidesForSinglePage = true
    }

    public func setLayout(
        itemSize: CGSize,
        minimumSpacing: CGFloat = DefaultValue.emptyCGFloat,
        sectionInset: UIEdgeInsets = UIEdgeInsets.zero,
        scrollDirection: UICollectionView.ScrollDirection = UICollectionView.ScrollDirection.horizontal,
        isShownScrollIndicator: Bool = false
    ) {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = scrollDirection
        layout.itemSize = itemSize
        layout.sectionInset = sectionInset
        layout.minimumLineSpacing = minimumSpacing
        layout.minimumInteritemSpacing = minimumSpacing
        collectionView.collectionViewLayout = layout
        collectionView.showsVerticalScrollIndicator = isShownScrollIndicator
        collectionView.showsHorizontalScrollIndicator = isShownScrollIndicator
    }

    public func startLoading() {
        activityIndicator.startAnimating()
        collectionView.reloadData()
    }

    public func stopLoading() {
        activityIndicator.stopAnimating()
        collectionView.reloadData()
    }

    public func hasSectionAtIndex(index: NSInteger) -> Bool {
        return index < sections.count
    }

    public func hasIndexPath(indexPath: IndexPath) -> Bool {
        return hasSectionAtIndex(index: indexPath.section)
            && sections[indexPath.section].hasItemAtIndex(indexPath.row)
    }

    open func appendSection(_ section: CollectionViewSection) {
        section.tag = sections.count
        self.sections.append(section)
    }

    public func appendSections(_ sections: [CollectionViewSection]) {
        for section in sections {
            appendSection(section)
        }
    }

    public func removeAllSection() {
        sections.removeAll()
    }

    public func scrollToVisible(row: CollectionViewCell) {
        guard let superview = row.superview else { return }
        let visibleRect = collectionView.convert(row.frame, to: superview)
        collectionView.scrollRectToVisible(visibleRect, animated: true)
    }

    public func dequeueReusableCellWithIdentifier(
        nibName: String,
        indexPath: IndexPath
    ) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(
            withReuseIdentifier: nibName,
            for: indexPath
        )
    }

    public func registerNib<T>(nibClass: T.Type, resource: String? = nil) where T: CollectionViewCell {
        var bundle: Bundle?
        if let resource = resource {
            let nibBundle = Bundle(for: nibClass.self)
            guard let url = nibBundle.url(forResource: resource, withExtension: "bundle") else { return }
            bundle = Bundle(url: url)
        }
        let nib = UINib(nibName: nibClass.className, bundle: bundle)
        if registeredCellIdentifiers.contains(nibClass.className) { return }
        registeredCellIdentifiers.append(nibClass.className)
        collectionView.register(nib, forCellWithReuseIdentifier: nibClass.className)
    }

    public func dequeueReusableNibCell<T>(
        nibClass: T.Type,
        indexPath: IndexPath,
        resource: String? = nil
    ) -> UICollectionViewCell where T: CollectionViewCell {
        registerNib(nibClass: nibClass, resource: resource)
        return dequeueReusableCellWithIdentifier(nibName: nibClass.className, indexPath: indexPath)
    }

    public func reloadSection(_ section: CollectionViewSection) {
        collectionView.reloadSections(IndexSet(integer: section.tag))
    }

    public func numberOfSections() -> Int {
        return sections.count
    }

    public func numberOfItems() -> Int {
        var total = 0
        for section in sections {
            total += section.numberOfItems()
        }
        return total
    }

    public func isEmpty() -> Bool {
        return numberOfItems() <= DefaultValue.emptyInt
    }

    public func scrollToTop() {
        collectionView.setContentOffset(.zero, animated: true)
    }

    public func render() {
        removeAllSection()
        renderPageControl()
    }
}

extension CollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        if hasSectionAtIndex(index: section) {
            let rows = sections[section].numberOfItems()
            pageControl?.numberOfPages = rows
            return rows
        }
        return 0
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        return UICollectionViewCell()
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = collectionView.cellForItem(at: indexPath) as? CollectionViewCell else { return }
        item.onSelected()
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControl?.currentPage = indexPath.row
    }
}

extension CollectionView: UIScrollViewDelegate {
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        collectionView.endEditing(true)
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.collectionViewDidScroll?(scrollView)
    }

    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegate?.collectionViewDidEndDecelerating?(scrollView)
    }
}
