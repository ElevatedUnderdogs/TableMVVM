//
//  SectionWithoutRowsTests.swift
//  
//
//  Created by Scott Lydon on 9/23/21.
//

import XCTest
@testable import TableMVVM

class SectionWithoutRowsTests: XCTestCase {

    typealias TheHeader = Header<HeaderFooter<TextView>>

    func testSectionWithoutRowsFallBack() {
        let fallBack = SectionWithoutRows<TheHeader>.fallBack
        XCTAssertEqual(fallBack.count, 0)
        XCTAssertEqual(fallBack.tableViewNumberOfRows(.init()), 0)
        XCTAssertNoThrow(fallBack.tableViewDidSelectRowAt(.init(), didSelectRowAt: .zero))
        XCTAssertEqual(String(describing: type(of: fallBack.tableView(.init(), cellForRowAt: .zero))), "UITableViewCell")
        XCTAssertNoThrow(fallBack.registerCells(tableView: .init()))
    }

    func testSectionDefaults() {
        let fallBack = SectionWithoutRows<TheHeader>.fallBack
        print(fallBack.header.headerViewModel)
        let other = SectionWithoutRows<TheHeader>(header: .fallBack)
        print(other.header.headerViewModel)
        XCTAssertEqual(fallBack.header.headerViewModel.string, other.header.headerViewModel.string)
        XCTAssertEqual(other.header.headerViewModel.string, "cats")
        XCTAssertEqual(fallBack.header.headerViewModel.string, "cats")
    }
}
