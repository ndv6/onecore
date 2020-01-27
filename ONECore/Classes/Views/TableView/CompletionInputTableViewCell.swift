//
//  CompletionInputTableViewCell.swift
//  Alamofire
//
//  Created by ALDO LAZUARDI on 05/07/19.
//

import UIKit

open class CompletionInputTableViewCell: TableViewCell {
    private var statusComplete: Bool = false

    open func setStatusComplete(_ statusComplete: Bool) {
        self.statusComplete = statusComplete
    }

    open func getStatusComplete() -> Bool {
        return statusComplete
    }
}
