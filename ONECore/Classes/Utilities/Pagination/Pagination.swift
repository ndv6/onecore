//
//  Pagination.swift
//  ONECore
//
//  Created by Sofyan Fradenza Adi on 04/02/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import Foundation

public class Pagination {
    private var pageSize: Int32 = 10
    private var currentPage: Int32 = 0
    private var nextPage: Int32 = 0

    public init(pageSize: Int32 = 10) {
        self.pageSize = pageSize
        self.reset()
    }

    public func newPage(numberOfRows: Int) {
        currentPage += 1
        nextPage = numberOfRows < pageSize ? currentPage : currentPage + 1
    }

    public func isLastPage() -> Bool {
        return nextPage == currentPage
    }

    public func getNextPage() -> Int32 {
        return nextPage
    }

    public func getPageSize() -> Int32 {
        return pageSize
    }

    public func reset() {
        currentPage = 0
        nextPage = 1
    }
}
