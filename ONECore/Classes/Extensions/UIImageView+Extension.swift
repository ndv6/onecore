//
//  UIImageView+Extension.swift
//  ONECore
//
//  Created by DENZA on 17/12/18.
//  Copyright © 2018 NDV6. All rights reserved.
//

import Foundation
import SDWebImage

extension UIImageView {
    public func downloadedFrom(
        link: String,
        placeholderImage: UIImage? = nil,
        completion: @escaping () -> Void = {}
    ) {
        image = placeholderImage
        if !link.isValidURL() { return }
        sd_setImage(with: URL(string: link), placeholderImage: placeholderImage, options: []) {(image, _, _, _) in
            var imageResult = UIImage()
            if image != nil {
                imageResult = image!
                completion()
            } else if placeholderImage != nil {
                imageResult = placeholderImage!
            }
            self.image = imageResult
        }
    }
}
