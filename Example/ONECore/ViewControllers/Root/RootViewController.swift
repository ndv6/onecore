//
//  RootViewController.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 23/12/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import ONECore

class RootViewController: UIViewController {
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    internal weak var delegate: RootViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.delegate?.rootViewControllerDidCompleted()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
