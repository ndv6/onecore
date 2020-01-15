//
//  MainMenuViewControllerDelegate.swift
//  ONECore_Example
//
//  Created by Sofyan Fradenza Adi on 23/12/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

protocol MainMenuViewControllerDelegate: class {
    func mainMenuViewControllerDidSelectMenu(_ menu: MenuItemViewModel)
    func mainMenuViewControllerWillAppear()
}
