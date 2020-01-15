//
//  FormTableViewController+SelectionInput.swift
//  Kelolala
//
//  Created by DENZA on 22/05/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import Foundation

extension FormTableViewController: SelectionInputDelegate {
    public func selectionInputDidEndEditing(_ selectionInput: SelectionInput) {
        refreshErrorMessage()
    }
}
