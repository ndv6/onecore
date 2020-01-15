//
//  TimeInterval+Format.swift
//  ONECore
//
//  Created by Sofyan Fradenza Adi on 20/09/19.
//

import Foundation

extension TimeInterval {
    public func convertToHumanTextFormat(separator: String = ":") -> String {
        let minutes = Int(self) / 60
        let seconds = Int(self) % 60
        return String(format: "%02d%@%02d", minutes, separator, seconds)
    }
}
