//
//  NavigationHelperTest.swift
//  OLCoreExtensionTests
//
//  Created by ALDO LAZUARDI on 27/12/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import ONECore

class NavigationHelperTest: XCTestCase {
    var mockViewController: ViewController!
    var presentedMockViewController: ViewController!
    var rootViewController: ViewController!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockViewController = ViewController()
        presentedMockViewController = ViewController()
        rootViewController = ViewController()
        UIApplication.shared.keyWindow?.rootViewController = mockViewController
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetCurrentViewController() {
        XCTAssertEqual(NavigationHelper.getCurrentViewController(), mockViewController)
        mockViewController.present(presentedMockViewController, animated: false, completion: nil)
        XCTAssertEqual(NavigationHelper.getCurrentViewController(), presentedMockViewController)
        UIApplication.shared.keyWindow?.rootViewController = nil
        XCTAssertEqual(NavigationHelper.getCurrentViewController(), nil)
    }

    func testResetToRootVC() {
        rootViewController.present(presentedMockViewController, animated: false, completion: nil)
        NavigationHelper.resetToRootVC(sender: presentedMockViewController)
        UIApplication.shared.keyWindow?.rootViewController = rootViewController
        XCTAssertEqual(
            NavigationHelper.getCurrentViewController(),
            rootViewController
        )
        NavigationHelper.resetToRootVC(sender: rootViewController)
        XCTAssertEqual(
            NavigationHelper.getCurrentViewController(),
            rootViewController
        )
    }
}
