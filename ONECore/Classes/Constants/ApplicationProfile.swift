//
//  ApplicationProfile.swift
//  ONECore
//
//  Created by CALISTA on 06/11/19.
//

import Foundation

public struct ApplicationProfile {
    public static var appName: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
            ?? DefaultValue.emptyString
    }
    public static var versionName: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
            ?? DefaultValue.emptyString
    }
    public static var buildNumber: Int {
        return Int(Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
            ?? DefaultValue.emptyString) ?? DefaultValue.emptyInt
    }
    public static var deviceId: String {
        guard let identifier = UIDevice.current.identifierForVendor else { return DefaultValue.emptyString }
        return identifier.uuidString
    }
}
