//
//  FormTableViewController+UITextView.swift
//  ONECore
//
//  Created by Sofyan Fradenza Adi on 10/01/19.
//  Copyright © 2019 NDV6. All rights reserved.
//

import UIKit

extension FormTableViewController: UITextViewDelegate {
    public func textViewDidBeginEditing(_ textView: UITextView) {
        guard let textArea = textView as? TextArea else { return }
        scrollToInput(textArea)
    }

    public func textViewDidEndEditing(_ textView: UITextView) {
        refreshErrorMessage()
    }

    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let textArea = textView as? TextArea else { return false }
        return textArea.shouldChangeTextHandler(range: range, replacementText: text)
    }

    public func textViewDidChangeSelection(_ textView: UITextView) {
        guard let textArea = textView as? TextArea else { return }
        textArea.didChangeSelectionHandler()
    }
}
