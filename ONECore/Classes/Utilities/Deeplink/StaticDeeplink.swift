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
    static let onemobile = "ocbcnispmobile://com.ocbcnisp.onemobile"
}

private struct StoreId {
    static let whatsapp = "310633997"
    static let onemobile = "1194942386"
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

    public func openOneMobile() {
        if !Link.onemobile.openDeeplink() {
            _ = openAppStore(storeId: StoreId.onemobile)
        }
    }
}
