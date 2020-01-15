//
//  ImageView.swift
//  ONECore
//
//  Created by Sofyan Fradenza Adi on 04/01/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import UIKit

open class ImageView: UIImageView {
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override open func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = CoreStyle.Color.imageBackground
    }
}
