//
//  ImageSelectionInputViewModel.swift
//  ONECore
//
//  Created by Sofyan Fradenza Adi on 16/01/20.
//

import Foundation

public class ImageSelectionInputViewModel {
    public var name: String = DefaultValue.emptyString
    public var defaultValue: String? = nil
    public var menuTitle: String = DefaultValue.emptyString
    public var cameraButtonTitle: String = DefaultValue.emptyString
    public var galleryButtonTitle: String = DefaultValue.emptyString
    public var cancelButtonText: String = DefaultValue.emptyString
    public var settingsButtonText: String = DefaultValue.emptyString
    public var permissionText: String = DefaultValue.emptyString
    public var compressionQuality: CGFloat = CGFloat(0)
    public var didChangeAction: InputDidChangeHandler = {_,_  in }
}
