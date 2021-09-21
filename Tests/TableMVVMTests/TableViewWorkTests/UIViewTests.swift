//
//  UIViewTests.swift
//  TableViewWorkTests
//
//  Created by Scott Lydon on 9/16/21.
//

import XCTest
@testable import TableMVVM

class UIViewTests: XCTestCase {

    func testInjectViewAlreadyThere() {
        let container = UIView()
        let subView = UIView()
        container.inject(view: subView)
        container.inject(view: subView)
        XCTAssertEqual(container.subviews.count, 1)
        XCTAssertTrue(container.subviews.contains(subView))
    }

    func testInjectReplaceView() {
        let container = UIView()
        let subView1 = UIView()
        let subView2 = UIView()
        container.inject(view: subView1)
        container.inject(view: subView2)
        XCTAssertTrue(container.subviews.contains(subView2))
        XCTAssertFalse(container.subviews.contains(subView1))
    }
}
