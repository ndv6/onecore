//
//  NSObject+ExtensionTest.swift
//  OLCoreExtensionTests
//
//  Created by Sofyan Fradenza Adi on 19/12/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import ONECore

class NSObjectTest: XCTestCase {
    var intValue: Int!

    func testClassName() {
        XCTAssertEqual(UITableViewController.className, "UITableViewController")
        XCTAssertEqual(FormTableViewController(nibName: nil, bundle: nil).className, "FormTableViewController")
    }
}
