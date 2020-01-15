//
//  DispatchQueue+Once.swift
//  DLRadioButton
//
//  Created by DENZA on 04/08/19.
//

import Foundation

public extension DispatchQueue {
    private static var _onceTracker = [String]()
    
    class func once(token: String, block: () -> Void) {
        objc_sync_enter(self); defer { objc_sync_exit(self) }
        if _onceTracker.contains(token) { return }
        _onceTracker.append(token)
        block()
    }
}
