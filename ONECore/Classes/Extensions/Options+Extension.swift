//
//  Options+Extension.swift
//  Kelolala
//
//  Created by DENZA on 22/05/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import Foundation

extension Array where Element: Option {
    public mutating func remove(_ targetOption: Option) {
        self.removeAll { (option) -> Bool in
            option.id == targetOption.id
        }
    }

    public func contains(_ findOption: Option) -> Bool {
        return self.contains { (option) -> Bool in
            option.id == findOption.id
        }
    }

    public func displayText(separator: String = Separator.phrase) -> String {
        var result = DefaultValue.emptyString
        for option in self {
            if !result.isEmpty {
                result += separator
            }
            result += option.text
        }
        return result
    }
}
