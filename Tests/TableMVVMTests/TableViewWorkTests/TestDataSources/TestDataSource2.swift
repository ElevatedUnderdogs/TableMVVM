//
//  TestDataSource2.swift
//  TableViewWorkTests
//
//  Created by Scott Lydon on 9/18/21.
//

import XCTest
@testable import TableMVVM

/// Tests to efficiently reach multiple components
class TestDataSource2: XCTestCase {

    func testTableDataSource1DidSelectRowsAT() {
        var testMe: String?
        var colorMe: UIColor?
        let dataSource: SimpleDS3 = SimpleDS3.fallBack { textVM, _ in
            testMe = textVM.string
            colorMe = nil
        } cellTapped1: { colorVM, _ in
            testMe = nil
            colorMe = colorVM
        } cellTapped2: { textVM, _ in
            testMe = textVM.string
            colorMe = nil
        }
        XCTAssertNil(testMe)
        XCTAssertEqual(testMe, nil)
        XCTAssertEqual(colorMe, nil)
        dataSource.tableView(.init(), didSelectRowAt: .zero)
        XCTAssertEqual(testMe, "hello")
        XCTAssertEqual(colorMe, nil)
        dataSource.tableView(.init(), didSelectRowAt: .init(row: 0, section: 1))
        XCTAssertEqual(testMe, nil)
        XCTAssertEqual(colorMe, .red)
        dataSource.tableView(.init(), didSelectRowAt: .init(row: 0, section: 2))
        XCTAssertEqual(testMe, "hello")
        XCTAssertEqual(colorMe, nil)
        dataSource.tableView(.init(), didSelectRowAt: .init(row: 0, section: 3))
    }

    // swiftlint:disable all
    func testTableDataSource1DidSelectRowAtNot0() {
    // swiftlint:enable all
        var testMe: String?
        var checkColor: UIColor?
        var indxPath: IndexPath?
        let dataSource: My4Table = My4Table.fallBack { color, indexPath in
            checkColor = color
            indxPath = indexPath
        } section1CellTap: { color, indexPath in
            checkColor = color
            indxPath = indexPath
        } oneRowTap: { textThing, indexPath in
            testMe = textThing.string
            indxPath = indexPath
        } tappedAction: { color, indexPath in
            checkColor = color
            indxPath = indexPath
        }

        XCTAssertEqual(testMe, nil)
        XCTAssertEqual(checkColor, nil)
        XCTAssertEqual(indxPath, nil)

        dataSource.tableView(UITableView(), didSelectRowAt: .zero)
        XCTAssertEqual(testMe, nil)
        XCTAssertEqual(checkColor, .blue)
        XCTAssertEqual(indxPath, .zero)

        let indx2 = IndexPath(row: 0, section: 1)
        dataSource.tableView(UITableView(), didSelectRowAt: indx2)
        XCTAssertEqual(testMe, nil)
        XCTAssertEqual(checkColor, .red)
        XCTAssertEqual(indxPath, indx2)

        let indx3 = IndexPath(row: 0, section: 2)
        dataSource.tableView(UITableView(), didSelectRowAt: indx3)
        XCTAssertEqual(testMe, nil)
        XCTAssertEqual(checkColor, .blue)
        XCTAssertEqual(indxPath, indx3)
        XCTAssertEqual(dataSource.section2.count, 1)
        XCTAssertEqual(dataSource.section2.currentSection.count, 1)
        dataSource.section2.section1.rows.item = .green
        dataSource.tableView(UITableView(), didSelectRowAt: indx3)
        XCTAssertEqual(testMe, nil)
        XCTAssertEqual(checkColor, .red)
        XCTAssertEqual(indxPath, indx3)
        XCTAssertEqual(dataSource.section2.count, 3)
        XCTAssertEqual(dataSource.section2.currentSection.count, 3)

        XCTAssertNotNil(dataSource.section2.registerCandidates[0] as? Section0)
        XCTAssertNotNil(dataSource.section2.registerCandidates[1] as? Section1)
        dataSource.section2.alternatingLogic = nil

        let indx4 = IndexPath(row: 0, section: 3)
        dataSource.tableView(UITableView(), didSelectRowAt: indx4)
        XCTAssertEqual(testMe, "wowza")
        XCTAssertEqual(checkColor, .red)
        XCTAssertEqual(indxPath, indx4)
        dataSource.section3.rows.rows1.item.string = "cow"
        dataSource.tableView(UITableView(), didSelectRowAt: indx4)
        XCTAssertEqual(testMe, "wowza")
        XCTAssertEqual(checkColor, .brown)
        XCTAssertEqual(indxPath, indx4)

        XCTAssertEqual(dataSource.section0.count, 1)
        XCTAssertEqual(ColorView(viewModel: .yellow).viewModel, .yellow)
    }

    func testOutsideBounds() {
        let dataSource: SimpleDS3 = SimpleDS3.fallBack()
        let table = UITableMVVM<SimpleDS3>()
        dataSource.registerCells(tableView: table)
        XCTAssertNotNil(dataSource.tableView(table, cellForRowAt: .init(item: 0, section: 3)))
        XCTAssertFalse(
            dataSource.tableView(table, cellForRowAt: .init(item: 0, section: 3)) is CellTF ||
                dataSource.tableView(table, cellForRowAt: .init(item: 0, section: 3)) is CellCV
        )
        XCTAssertEqual(dataSource.tableView(table, numberOfRowsInSection: 3), 0)
        XCTAssertEqual(dataSource.tableView(table, heightForHeaderInSection: 3), 0)
        XCTAssertNil(dataSource.tableView(table, viewForHeaderInSection: 3))
        // Not sure how to test `do {}`
        dataSource.tableView(table, didSelectRowAt: .init(row: 0, section: 3))
        XCTAssertEqual(dataSource.numberOfSections(in: table), 3)
    }
}
