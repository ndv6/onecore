//
//  ImageInputTableViewCell.swift
//  ONECore
//
//  Created by Steven Tiolie on 29/05/19.
//

import UIKit

open class ImageInputTableViewCell: TableViewCell, ImagePickerDelegate {
    open func imagePickerDidSelect(image: UIImage, fileSizeInKB: Int) {}
    private var selectedPhoto: UIImage?
    private var url: String?

    open func setSelectedPhoto(image: UIImage) {
        selectedPhoto = image
    }

    open func getSelectedPhoto() -> UIImage? {
        return selectedPhoto
    }

    open func setImageUrl(urlImage: String) {
        url = urlImage
    }

    open func getImageUrl() -> String? {
        return url
    }

    open func removeSelectedPhoto() {
        return selectedPhoto = nil
    }

    open func removeImageUrl() {
        return url = nil
    }
}
