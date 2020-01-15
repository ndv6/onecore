//
//  UIImage+Convertion.swift
//  ONECore
//
//  Created by DENZA on 03/12/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import UIKit

extension UIImage {
    public func alpha(_ value: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(
            at: CGPoint.zero,
            blendMode: .normal,
            alpha: value
        )
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { return self }
        UIGraphicsEndImageContext()
        return newImage
    }

    public func toString() -> String {
        guard let data: Data = self.pngData() else { return DefaultValue.emptyString }
        return data.base64EncodedString(options: .endLineWithLineFeed)
    }
}
