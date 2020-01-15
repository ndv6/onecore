//
//  ImagePicker.swift
//  Kelolala
//
//  Created by Steven Tiolie on 28/05/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import UIKit
import AVFoundation

public protocol ImagePickerDelegate: class {
    func imagePickerDidSelect(image: UIImage, fileSizeInKB: Int)
}

open class ImagePicker: NSObject {
    private let pickerController: UIImagePickerController
    private var overlay: UIView = UIView()
    private weak var presentationController: UIViewController?
    private weak var delegate: ImagePickerDelegate?
    private var alertController: UIAlertController!
    private var compressionQuality: CGFloat!
    private var cancelButtonText: String = DefaultValue.emptyString
    private var settingsButtonText: String = DefaultValue.emptyString
    private var permissionText: String = DefaultValue.emptyString
    
    public init(
        presentationController: UIViewController,
        delegate: ImagePickerDelegate,
        overlay: UIView,
        compressionQuality: CGFloat = 0.5,
        cancelButtonText: String = DefaultValue.emptyString,
        settingsButtonText: String = DefaultValue.emptyString,
        permissionText: String = DefaultValue.emptyString
    ) {
        self.pickerController = UIImagePickerController()
        super.init()
        self.presentationController = presentationController
        self.delegate = delegate
        self.pickerController.delegate = self
        self.pickerController.allowsEditing = false
        self.pickerController.mediaTypes = ["public.image"]
        self.compressionQuality = compressionQuality
        self.overlay = overlay
        self.cancelButtonText = cancelButtonText
        self.settingsButtonText = settingsButtonText
        self.permissionText = permissionText
    }
    
    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }
        
        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            self.pickerController.sourceType = type
            if self.pickerController.sourceType == .camera {
                self.pickerController.cameraFlashMode = .off
                self.pickerController.cameraCaptureMode = .photo
                self.pickerController.cameraDevice = .rear
                
                /*Camera*/
                AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
                    if response {
                        self.presentationController?.present(self.pickerController, animated: true)
                    } else {
                        self.showCameraPermission()
                    }
                }
                return
            }
            
            self.presentationController?.present(self.pickerController, animated: true)
        }
    }

    public func presentGalleryPhoto() {
        self.pickerController.sourceType = .photoLibrary
        self.presentationController?.present(self.pickerController, animated: true)
    }

    public func present(from sourceView: UIView, menuTitle: String, cameraButtonTitle: String, galleryButtonTitle: String ) {
        
        alertController = UIAlertController(title: menuTitle, message: nil, preferredStyle: .actionSheet)
        
        if let action = self.action(for: .camera, title: cameraButtonTitle) {
            alertController.addAction(action)
        }
        if let action = self.action(for: .photoLibrary, title: galleryButtonTitle) {
            alertController.addAction(action)
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.popoverPresentationController?.sourceView = sourceView
            alertController.popoverPresentationController?.sourceRect = sourceView.bounds
            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }
        
        let gesture = UITapGestureRecognizer(
            target: self,
            action: #selector(self.closeAlert)
        )
        
        self.presentationController?.present(alertController, animated: true, completion: {
            self.alertController.view.superview?.isUserInteractionEnabled = true
            self.alertController.view.superview?.subviews.first?.addGestureRecognizer(gesture)
        })
    }
    
    @objc func closeAlert() {
        alertController.dismiss(animated: true, completion: nil)
    }

    private func showCameraPermission() {
        let settingAction = UIAlertAction(
            title: settingsButtonText,
            style: .default,
            handler: { (action) in
                guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
                if UIApplication.shared.canOpenURL(url) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
            }
        )
        let cancelAction = UIAlertAction(
            title: cancelButtonText,
            style: .cancel,
            handler: nil
        )
        let permissionAlert = UIAlertController(
            title: DefaultValue.emptyString,
            message: permissionText,
            preferredStyle: .alert
        )
        permissionAlert.addAction(settingAction)
        permissionAlert.addAction(cancelAction)
        self.presentationController?.present(permissionAlert, animated: true, completion: nil)
    }
    
    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        controller.dismiss(animated: true, completion: nil)
        if let tempImage = image {
            if let imageData = tempImage.jpegData(compressionQuality: self.compressionQuality) {
                let imageSizeinKB: Int = imageData.count / 1000
                guard let selectedImage = UIImage(data: imageData) else { return }
                self.delegate?.imagePickerDidSelect(image: selectedImage, fileSizeInKB: imageSizeinKB)
            }
        }
    }
}

extension ImagePicker: UIImagePickerControllerDelegate {
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.pickerController(picker, didSelect: nil)
    }

    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            return self.pickerController(picker, didSelect: nil)
        }
        self.pickerController(picker, didSelect: image.fixImageOrientation())
    }
}

extension ImagePicker: UINavigationControllerDelegate {}

