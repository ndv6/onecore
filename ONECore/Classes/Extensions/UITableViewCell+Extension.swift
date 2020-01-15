//
//  UITableViewCell+Extension.swift
//  ONECore
//
//  Created by DENZA on 07/11/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

extension UITableViewCell {
    public func removeSeparator(tableView: UITableView?) {
        var insetLeft = SizeHelper.ScreenWidth
        if tableView != nil {
            insetLeft = tableView!.frame.size.width
        }
        self.separatorInset = UIEdgeInsets(top: 0, left: insetLeft, bottom: 0, right: 0)
    }

    public func addSeparator(tableView: UITableView) {
        let top = tableView.separatorInset.top
        let left = tableView.separatorInset.left
        let bottom = tableView.separatorInset.bottom
        let right = tableView.separatorInset.right
        self.separatorInset = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }

    public func drawSeparator(tableView: UITableView, indexPath: IndexPath, rowCount: NSInteger) {
        if indexPath.row == rowCount - 1 {
            self.removeSeparator(tableView: tableView)
        } else {
            self.addSeparator(tableView: tableView)
        }
    }
}
