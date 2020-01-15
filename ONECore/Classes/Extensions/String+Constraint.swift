//
//  String+Constraint.swift
//  ONECore
//
//  Created by Sofyan Fradenza Adi on 29/10/19.
//

import UIKit

extension String {
    public func estimatedHeight(
        width: CGFloat,
        font: UIFont
    ) -> CGFloat {
        let boundingBox = self.boundingRect(
            with: CGSize(
                width: width,
                height: .greatestFiniteMagnitude
            ),
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil
        )
        return ceil(boundingBox.height)
    }

    public func estimatedWidth(
        height: CGFloat,
        font: UIFont
    ) -> CGFloat {
        let boundingBox = self.boundingRect(
            with: CGSize(
                width: .greatestFiniteMagnitude,
                height: height
            ),
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil
        )
        return ceil(boundingBox.width)
    }
}
