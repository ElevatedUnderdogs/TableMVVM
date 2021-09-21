//
//  ContainerTests.swift
//  TableViewWorkTests
//
//  Created by Scott Lydon on 9/16/21.
//

import XCTest
@testable import TableMVVM

class ContainerTests: XCTestCase {

    func testContainerInit() {
        let new = Container<TextView>()
        XCTAssertEqual(new.viewModel.insets, .zero)
        XCTAssertEqual(new.viewModel.viewModel.string, "cats")
    }

    func testContainerBla() {
        let new = Container<TextView>()
        new.viewModel = .init(insets: .one, viewModel: .init(string: "dogs"))
        XCTAssertEqual(new.subviews.count, 1)
        XCTAssertEqual(new.viewModel.viewModel.string, "dogs")
    }
}

extension UIEdgeInsets {
    static var one: UIEdgeInsets {
        .init(top: 1, left: 1, bottom: 1, right: 1)
    }
}
