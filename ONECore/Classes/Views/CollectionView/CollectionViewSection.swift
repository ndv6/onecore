//
//  CollectionViewSection.swift
//  ONECore
//
//  Created by Sofyan Fradenza Adi on 27/12/19.
//

import Foundation

open class CollectionViewSection {
    private var title: String = DefaultValue.emptyString
    private var items: [AnyObject] = []
    public var tag: Int = 0
    public var isEmpty: Bool {
        return numberOfItems() == DefaultValue.emptyInt
    }

    public init() {}

    public func numberOfItems() -> NSInteger {
        return items.count
    }

    public func hasItemAtIndex(_ index: NSInteger) -> Bool {
        return index < items.count
    }

    public func appendItem(_ item: AnyObject) {
        items.insert(item, at: items.count)
    }

    public func setItems(items: [AnyObject]) {
        self.items = items
    }

    public func getItemAtIndex(_ index: NSInteger) -> AnyObject {
        if hasItemAtIndex(index) {
            return items[index]
        }
        return NSObject()
    }

    public func removeAllItems() {
        items.removeAll()
    }
}
