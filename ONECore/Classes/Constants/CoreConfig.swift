//
//  CoreConfig.swift
//  ONECore
//
//  Created by Sofyan Fradenza Adi on 13/09/19.
//

import Foundation

public struct CoreConfig {
    public struct FormTableViewController {
        public static var isAutoAvoidKeyboard: Bool = true
    }
    public struct TableViewController {
        public static var isAutoRenderOnEveryViewWillAppear: Bool = false
        public static var isReloadDataWithoutScrollAnimation: Bool = true
    }
}
