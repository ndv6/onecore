//
//  String+HtmlText.swift
//  ONECore
//
//  Created by kuh on 14/09/20.
//

import Foundation

extension String {
    func convertHtmlToAttributedString() -> NSMutableAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        return try? NSMutableAttributedString(
            data: data,
            options: [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ],
            documentAttributes: nil
        )
    }
}
