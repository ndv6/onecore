//
//  SectionCollection.swift
//  ONECore
//
//  Created by DENZA on 04/12/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

private struct EmptySize {
    static let xxSmall = CoreStyle.EmptySection.xxSmall
    static let xSmall = CoreStyle.EmptySection.xSmall
    static let small = CoreStyle.EmptySection.small
    static let medium = CoreStyle.EmptySection.medium
    static let large = CoreStyle.EmptySection.large
    static let xLarge = CoreStyle.EmptySection.xLarge
    static let xxLarge = CoreStyle.EmptySection.xxLarge
}

open class SectionCollection {
    private var contentView: TableView = TableView()
    public init() {}
    public var emptyXXSmall: EmptySection {
        let section = EmptySection()
        section.configure(contentView: contentView, height: EmptySize.xxSmall)
        return section
    }
    public var emptyXSmall: EmptySection {
        let section = EmptySection()
        section.configure(contentView: contentView, height: EmptySize.xSmall)
        return section
    }
    public var emptySmall: EmptySection {
        let section = EmptySection()
        section.configure(contentView: contentView, height: EmptySize.small)
        return section
    }
    public var emptyMedium: EmptySection {
        let section = EmptySection()
        section.configure(contentView: contentView, height: EmptySize.medium)
        return section
    }
    public var emptyLarge: EmptySection {
        let section = EmptySection()
        section.configure(contentView: contentView, height: EmptySize.large)
        return section
    }
    public var emptyXLarge: EmptySection {
        let section = EmptySection()
        section.configure(contentView: contentView, height: EmptySize.xLarge)
        return section
    }
    public var emptyXXLarge: EmptySection {
        let section = EmptySection()
        section.configure(contentView: contentView, height: EmptySize.xxLarge)
        return section
    }
    public var activityIndicator: ActivityIndicatorSection {
        let section = ActivityIndicatorSection()
        section.configure(contentView: contentView, style: .gray)
        return section
    }
    public var lightActivityIndicator: ActivityIndicatorSection {
        let section = ActivityIndicatorSection()
        section.configure(contentView: contentView, style: .white)
        return section
    }
    public func configure(contentView: TableView) {
        self.contentView = contentView
    }
}
