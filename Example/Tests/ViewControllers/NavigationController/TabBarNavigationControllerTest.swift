//
//  TabBarNavigationControllerTest.swift
//  OLCoreExtensionTests
//
//  Created by ALDO LAZUARDI on 30/12/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import ONECore

class TabBarNavigationControllerTest: XCTestCase {
    var mockTabNavigationController: MockTabNavigationController!
    var mockViewController: ViewController!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockTabNavigationController = MockTabNavigationController(
            tintColor: .white,
            backgroundColor: .black
        )
        mockViewController = ViewController()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInit() {
        _ = TabBarNavigationController(tintColor: .white, backgroundColor: .black)
        XCTAssertEqual( UITabBar.appearance().tintColor, .white)
        XCTAssertEqual( UITabBar.appearance().barTintColor, .black)
        XCTAssertEqual( UITabBar.appearance().backgroundColor, .black)
    }

    func testGetFirstNavigationController() {
        let expected = "1"
        XCTAssertEqual(mockTabNavigationController.getFirstNavigationController().title, expected)
    }

    func testMoveToController() {
        _ = mockTabNavigationController.moveToController(SecondViewController.self)
        XCTAssertEqual(mockTabNavigationController.selectedIndex, 1)
        XCTAssertEqual(
            mockTabNavigationController.moveToController(ViewController.self),
            nil
        )
    }

    func testMoveToFirstPage() {
        mockTabNavigationController.moveToFirstPage()
        XCTAssertEqual(mockTabNavigationController.selectedIndex, 0)
    }
}

class MockTabNavigationController: TabBarNavigationController {
    override var navigationControllers: [NavigationController] {
        let mockViewController = FirstViewController()
        mockViewController.title = "1"
        return [
            NavigationHelper.createTabBarItemNavigationController(
                title: "first",
                icon: UIImage(),
                font: .systemFont(ofSize: 10),
                selectedIcon: UIImage(),
                viewController: mockViewController
            ),
            NavigationHelper.createTabBarItemNavigationController(
                title: "second",
                icon: UIImage(),
                font: .systemFont(ofSize: 10),
                selectedIcon: UIImage(),
                viewController: SecondViewController()
            )
        ]
    }
}

class FirstViewController: ViewController {}

class SecondViewController: ViewController {}
