//
//  StaticDeeplink.swift
//  ONECore
//
//  Created by DENZA on 08/03/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import Foundation

private struct Link {
    static let appstore = "itms-apps://itunes.apple.com/app/id%@"
    static let whatsapp = "whatsapp://send?phone=%@"
}

private struct StoreId {
    static let whatsapp = "310633997"
}

public class StaticDeeplink {
    public static let instance = StaticDeeplink()

    public func openAppStore(storeId: String) -> Bool {
        return String(format: Link.appstore, storeId).openDeeplink()
    }

    public func openWhatsapp(phoneNumber: String) {
        if !String(format: Link.whatsapp, phoneNumber).openDeeplink() {
            _ = openAppStore(storeId: StoreId.whatsapp)
        }
    }

    public func openApps(schemeURL: String, storeId: String) {
        if !schemeURL.openDeeplink() {
            _ = openAppStore(storeId: storeId)
        }
    }
}
