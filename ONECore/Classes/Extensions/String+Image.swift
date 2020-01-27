//
//  String+Image.swift
//  ONECore
//
//  Created by NICKO PRASETIO on 31/10/19.
//

import Foundation

extension String {
    public func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters) {
            return UIImage(data: data)
        }
        return nil
    }
}
