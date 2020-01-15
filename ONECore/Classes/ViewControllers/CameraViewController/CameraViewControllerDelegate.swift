//
//  CameraViewControllerDelegate.swift
//  ONECore
//
//  Created by Sofyan Fradenza Adi on 25/10/19.
//

import Foundation

@objc public protocol CameraViewControllerDelegate: class {
    func cameraViewControllerDidTakePicture(originalImage: UIImage, croppedImage: UIImage)
}
