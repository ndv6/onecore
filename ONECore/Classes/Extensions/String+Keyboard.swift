//
//  String+Keyboard.swift
//  ONECore
//
//  Created by Sofyan Fradenza Adi on 29/10/19.
//

import Foundation

extension String {
    public func copyToKeyboard() {
        UIPasteboard.general.string = self
    }

    public func pasteFromKeyboard() -> String {
        return UIPasteboard.general.string ?? DefaultValue.emptyString
    }
}
