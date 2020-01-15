//
//  Data+DebugTools.swift
//  ONECore
//
//  Created by Sofyan Fradenza Adi on 14/11/19.
//

import Foundation

extension Data {
    public var prettyPrintedJsonString: String {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
            let data = try? JSONSerialization.data(
                withJSONObject: object,
                options: [.prettyPrinted]
            ),
            let prettyPrintedString = NSString(
                data: data,
                encoding: String.Encoding.utf8.rawValue
            ) as String? else { return DefaultValue.emptyString }
        return prettyPrintedString
    }
}
