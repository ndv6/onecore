//
//  InfiniteScroll.swift
//  ONECore
//
//  Created by Sofyan Fradenza Adi on 11/12/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

open class InfiniteScroll {
    private var indicatorSection: ActivityIndicatorSection = ActivityIndicatorSection()
    public var isLoading: Bool = false
    public var threshold: CGFloat = 150
    public var isEnabled: Bool = false

    public init(indicatorSection: ActivityIndicatorSection = ActivityIndicatorSection()) {
        self.indicatorSection = indicatorSection
    }

    public func isNeedToShowingIndicator() -> Bool {
        return isEnabled && isLoading
    }
}
