//
//  NavigationControllerTest.swift
//  OLCoreExtensionTests
//
//  Created by ALDO LAZUARDI on 27/12/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import ONECore

class NavigationControllerTest: XCTestCase {
    var mockNavigationController: NavigationController!
    var mockViewController: ViewController!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockViewController = ViewController()
        mockNavigationController = NavigationController(rootViewController: mockViewController)
        UIApplication.shared.keyWindow?.rootViewController = mockNavigationController
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetFirstViewController() {
        XCTAssertEqual(mockNavigationController.getFirstViewController(), mockViewController)
    }

    func testGestureRecognizerShouldBegin() {
        XCTAssertFalse(mockNavigationController.gestureRecognizerShouldBegin(UIGestureRecognizer()))
        mockNavigationController.pushViewController(
            ViewController(),
            animated: false
        )
        XCTAssertTrue(mockNavigationController.gestureRecognizerShouldBegin(UIGestureRecognizer()))
        let viewControllersCount = mockNavigationController.viewControllers.count
        mockNavigationController.removePreviousController()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
            XCTAssertEqual(self.mockNavigationController.viewControllers.count, viewControllersCount - 1)
        })
    }
}
