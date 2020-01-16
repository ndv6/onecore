//
//  PreviewFile.swift
//  Alamofire
//
//  Created by ALDO LAZUARDI on 08/11/19.
//

import UIKit

open class PreviewFile: NSObject, UIDocumentInteractionControllerDelegate {
    private var controller: UIViewController
    private var documentInteractionController: UIDocumentInteractionController?

    public init(controller: UIViewController) {
        self.controller = controller
        super.init()
    }

    public func previewFile(path: URL) {
        documentInteractionController = UIDocumentInteractionController(url: path)
        documentInteractionController?.delegate = self
        documentInteractionController?.presentPreview(animated: true)
    }

    public func documentInteractionControllerViewControllerForPreview(
        _ controller: UIDocumentInteractionController
    ) -> UIViewController {
        return self.controller
    }
}
