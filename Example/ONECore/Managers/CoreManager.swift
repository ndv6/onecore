//
//  CoreManager.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 26/12/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import ONECore

class CoreManager {
    static let instance = CoreManager()

    func setup() {
        setupConfig()
        setupCoreFont()
        setupCoreColor()
        setupCoreEmptySection()
        setupErrorMessages()
        setupCoreImage()
    }

    private func setupConfig() {
        CoreConfig.FormTableViewController.isAutoAvoidKeyboard = true
        CoreConfig.TableViewController.isAutoRenderOnEveryViewWillAppear = true
    }

    private func setupCoreFont() {
        CoreStyle.Font.navigationTitle = UIFont.systemFont(
            ofSize: FontSize.headline4,
            weight: UIFont.Weight.bold
        )
    }

    private func setupCoreColor() {
        CoreStyle.Color.navigationBackground = Colors.primary
        CoreStyle.Color.navigationText = UIColor.white
        CoreStyle.Color.primaryBackground = UIColor.white
        CoreStyle.Color.imageBackground = UIColor.lightGray
        CoreStyle.Color.refreshControlTintColor = Colors.primary
    }

    private func setupCoreEmptySection() {
        CoreStyle.EmptySection.xxSmall = CGFloat(8)
        CoreStyle.EmptySection.xSmall = CGFloat(16)
        CoreStyle.EmptySection.small = CGFloat(24)
        CoreStyle.EmptySection.medium = CGFloat(32)
    }

    private func setupCoreImage() {
        if let backButtonImage = UIImage(named: "backButton") {
            CoreStyle.Image.navigationBackButton = backButtonImage
        }
    }

    private func setupErrorMessages() {}
}
