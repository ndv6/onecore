//
//  Int+Extension.swift
//  ONECore
//
//  Created by DENZA on 07/12/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

extension Int {
    public func percentOf(_ total: Int) -> Int {
        let percentage = Double(self) / Double(total) * 100
        return Int(percentage.rounded())
    }

    public func convertToPercentage() -> CGFloat {
        return CGFloat(self) / 100
    }
}
