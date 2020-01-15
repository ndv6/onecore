//
//  String+Url.swift
//  ONECore
//
//  Created by Sofyan Fradenza Adi on 29/10/19.
//

import Foundation
import SafariServices

extension String {
    public func makeACall() {
        guard let number = URL(string: "tel://" + self) else { return }
        if UIApplication.shared.canOpenURL(number) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(number)
            } else {
                UIApplication.shared.openURL(number)
            }
        }
    }

    public func openURL(sender: UIViewController, delegate: SFSafariViewControllerDelegate? = nil) {
        if isValidURL() {
            if let url = URL(string: self) {
                let safariVC = SFSafariViewController(url: url)
                safariVC.delegate = delegate
                sender.present(safariVC, animated: true, completion: nil)
            }
        }
    }

    public func openURL(presenter: UINavigationController, delegate: SFSafariViewControllerDelegate? = nil) {
        if isValidURL() {
            if let url = URL(string: self) {
                let safariVC = SFSafariViewController(url: url)
                safariVC.delegate = delegate
                presenter.present(safariVC, animated: true, completion: nil)
            }
        }
    }

    public func openDeeplink() -> Bool {
        if isValidURL() {
            if let url = URL(string: self),
                UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    return true
                } else {
                    UIApplication.shared.openURL(url)
                    return true
                }
            }
        }
        return false
    }

    public func share(
        presenter: UINavigationController,
        excludedActivityTypes: [UIActivity.ActivityType]? = UIActivityTypes.excludedFromShareText
    ) {
        var activityViewController = UIActivityViewController(activityItems: [], applicationActivities: nil)
        if isValidURL() {
            guard let link = URL(string: self) else { return }
            activityViewController = UIActivityViewController(
                activityItems: [link],
                applicationActivities: nil
            )
        } else {
            activityViewController = UIActivityViewController(
                activityItems: [self],
                applicationActivities: nil
            )
        }
        activityViewController.popoverPresentationController?.sourceView = presenter.view
        activityViewController.excludedActivityTypes = excludedActivityTypes
        presenter.present(activityViewController, animated: true, completion: nil)
    }
}
