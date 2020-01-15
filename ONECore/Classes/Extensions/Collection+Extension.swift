//
//  Collection+Extension.swift
//  ONECore
//
//  Created by Sofyan Fradenza Adi on 03/01/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
    public subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
