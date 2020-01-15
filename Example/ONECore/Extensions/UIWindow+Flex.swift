//
//  UIWindow+Flex.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 11/04/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

#if DEBUG
import FLEX

extension UIWindow {
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            FLEXManager.shared().showExplorer()
        }
    }
}
#endif
