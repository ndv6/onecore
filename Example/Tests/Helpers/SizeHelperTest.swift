//
//  SizeHelperTest.swift
//  OLCoreExtensionTests
//
//  Created by ALDO LAZUARDI on 23/12/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import ONECore

class SizeHelperTest: XCTestCase {
    var frame: CGRect!

    override func setUp() {
        frame = CGRect(x: 0, y: 0, width: 320, height: 900)
    }

    override func tearDown() {}

    func testGetHeight() {
        let input = SizeHelper.getHeight(containerHeight: 100, verticalPadding: 5)
        let expected: CGFloat = 90
        XCTAssertEqual(input, expected)
    }

    func testGetHeightOfContainer() {
        let input = SizeHelper.getHeightOfContainer(
            lastFrame: CGRect(x: 0, y: 0, width: 100, height: 100),
            paddingBottom: 5
        )
        let expected: CGFloat = 105
        XCTAssertEqual(input, expected)
    }

    func testGetWidth() {
        let input = SizeHelper.getWidth(containerWidth: 100, horizontalPadding: 5)
        let expected: CGFloat = 90
        XCTAssertEqual(input, expected)
    }

    func testGetWidthGrid() {
        let input = SizeHelper.getWidthGrid(
            containerWidth: 100,
            horizontalPadding: 5,
            columnSpacing: 5,
            columnCount: 4
        )
        let expected: CGFloat = 18.75
        XCTAssertEqual(input, expected)
    }

    func testGetWidthOfScaled() {
        let input = SizeHelper.getWidthOfScale(
            height: 100,
            realWidth: 320,
            realHeight: 1000
        )
        let expected: CGFloat = 32
        XCTAssertEqual(input, expected)
    }

    func testGetHeightOfScaled() {
        let input = SizeHelper.getHeightOfScale(
            width: 100,
            realWidth: 320,
            realHeight: 1000
        )
        let expected: CGFloat = 312.5
        XCTAssertEqual(input, expected)
    }

    func testGetOriginXAlignCenter() {
        let input = SizeHelper.getOriginXAlignCenter(width: 100, containerWidth: 300)
        let expected: CGFloat = 100
        XCTAssertEqual(input, expected)
    }

    func testGetOriginXAlignRight() {
        let input = SizeHelper.getOriginXAlignRight(width: 100, containerWidth: 300, marginRight: 10)
        let expected: CGFloat = 190
        XCTAssertEqual(input, expected)
    }

    func testGetOriginYAlignCenter() {
        let input = SizeHelper.getOriginYAlignCenter(height: 100, containerHeight: 300)
        let expected: CGFloat = 100
        XCTAssertEqual(input, expected)
    }

    func testGetOriginYAlignBottom() {
        let input = SizeHelper.getOriginYAlignBottom(height: 100, containerHeight: 300, marginBottom: 10)
        let expected: CGFloat = 190
        XCTAssertEqual(input, expected)
    }

    func testGetOriginXAfterFrame() {
        let input = SizeHelper.getOriginXAfterFrame(frame: frame, horizontalMargin: 10)
        let expected: CGFloat = 330
        XCTAssertEqual(input, expected)
    }

    func testGetOriginYAfterFrame() {
        let input = SizeHelper.getOriginYAfterFrame(frame: frame, verticalMargin: 10)
        let expected: CGFloat = 910
        XCTAssertEqual(input, expected)
    }

    func testGetOffsetBottom() {
        let input = SizeHelper.getOffsetBottom(frame: frame)
        let expected: CGFloat = 900
        XCTAssertEqual(input, expected)
    }

    func testGetPercentValue() {
        let input = SizeHelper.getPercentValue(percent: 70, valueOf: 100)
        let expected: CGFloat = 70
        XCTAssertEqual(input, expected)
    }

    func testGetOriginYBeforeFrame() {
        let input = SizeHelper.getOriginYBeforeFrame(
            frame: frame,
            beforeFrame: CGRect(
                x: 0,
                y: 1000,
                width: 1000,
                height: 3000
            ),
            verticalMargin: 10
        )
        let expected: CGFloat = 90
        XCTAssertEqual(input, expected)
    }
}
