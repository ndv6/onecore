//
//  String+DebugTools.swift
//  ONECore
//
//  Created by Sofyan Fradenza Adi on 14/11/19.
//

import Foundation

extension String {
    public var prettyPrintedJsonString: String {
        guard let data = self.data(using: .utf8) else { return DefaultValue.emptyString }
        return data.prettyPrintedJsonString
    }
}
