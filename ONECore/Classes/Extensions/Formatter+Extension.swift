//
//  Formatter+Extension.swift
//  ONECore
//
//  Created by DENZA on 07/12/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import Foundation

extension Formatter {
    public static let thousandSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = Separator.thousand
        formatter.numberStyle = .decimal
        return formatter
    }()
}
