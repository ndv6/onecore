//
//  UIImage+Compression.swift
//  ONECore
//
//  Created by Sofyan Fradenza Adi on 30/10/19.
//

import UIKit

public typealias UIImageDidCompressHandler = (_ imageData: Data?) -> Void

extension UIImage {
    public enum JpegQuality: CGFloat {
        case lowest = 0.1
        case low = 0.25
        case medium = 0.5
        case high = 0.75
        case highest = 1.0
    }

    public func jpeg(_ jpegQuality: JpegQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }

    public func compressToExpectedSize(
        inKb expectedSize: CGFloat,
        compressionRatio: CGFloat = JpegQuality.medium.rawValue,
        didCompress: @escaping UIImageDidCompressHandler
    ) {
        let sizeInBytes = expectedSize * 1000
        var compressingValue = compressionRatio
        DispatchQueue.global(qos: .userInitiated).async {
            while true {
                let data = self.jpegData(compressionQuality: compressingValue)
                if compressingValue <= JpegQuality.lowest.rawValue {
                    DispatchQueue.main.async {
                        didCompress(data)
                    }
                    return
                }
                if let imageData = data, CGFloat(imageData.count) < sizeInBytes {
                    DispatchQueue.main.async {
                        didCompress(data)
                    }
                    return
                }
                compressingValue -= JpegQuality.lowest.rawValue
            }
        }
    }

    public func resizeToWidth(width: CGFloat) -> UIImage {
        let canvas = CGSize(
            width: width,
            height: CGFloat(ceil(width / size.width * size.height))
        )
        if #available(iOS 10.0, *) {
            return UIGraphicsImageRenderer(
                size: canvas,
                format: imageRendererFormat
            ).image { _ in
                draw(in: CGRect(origin: .zero, size: canvas))
            }
        } else {
            return self
        }
    }
}
