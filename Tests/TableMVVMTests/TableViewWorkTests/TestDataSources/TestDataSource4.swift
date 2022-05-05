//
//  TestDataSource4.swift
//  TableViewWorkTests
//
//  Created by Scott Lydon on 9/19/21.
//

import XCTest
@testable import TableMVVM

extension SimpleDS5 {

    static func fallBack(
        cellTapped0: TextSection.TextCellTapAction? = nil,
        cellTapped1: ColorSection.CellTapAction? = nil,
        cellTapped2: TextSection.TextCellTapAction? = nil,
        cellTapped3: ColorSection.CellTapAction? = nil,
        cellTapped4: TextSection.TextCellTapAction? = nil
    ) -> SimpleDS5 {
        SimpleDS5(
            section0: .fallBack(cellTapped: cellTapped0),
            section1: .fallBack(cellTapped: cellTapped1),
            section2: .fallBack(cellTapped: cellTapped2),
            section3: .fallBack(cellTapped: cellTapped3),
            section4: .fallBack(cellTapped: cellTapped4)
        )
    }
}

/// Tests to efficiently reach multiple components
class TestDataSource5: XCTestCase {

    func testDataSourceIsEmpty() {
        let dataSource: SimpleDS8 = SimpleDS8.fallBack
        dataSource.section0.cellsViewModels = []
        dataSource.section1.cellsViewModels = []
        dataSource.section2.cellsViewModels = []
        dataSource.section3.cellsViewModels = []
        dataSource.section4.cellsViewModels = []
        dataSource.section5.cellsViewModels = []

        XCTAssertTrue(dataSource.isEmpty)
        dataSource.section0.cellsViewModels = [.init(string: "cats")]
        XCTAssertFalse(dataSource.isEmpty)
        dataSource.section0.cellsViewModels = []
        XCTAssertTrue(dataSource.isEmpty)
        dataSource.section1.cellsViewModels = [.black]
        XCTAssertFalse(dataSource.isEmpty)
        dataSource.section1.cellsViewModels = []
        XCTAssertTrue(dataSource.isEmpty)
        dataSource.section5.cellsViewModels = [.black]
        XCTAssertFalse(dataSource.isEmpty)
        dataSource.section5.cellsViewModels = []
    }

    // MARK: - TableDataSource1
    func testTableDataSource1ReloadData() {
        let dataSource: SimpleDS5 = SimpleDS5.fallBack()
        dataSource.queue = DispatchQueueMock()
        dataSource.section0 = .init()
        dataSource.section1 = .init()
        dataSource.section2 = .init()
        dataSource.section3 = .init()
        dataSource.section4 = .init()
    }

    func testTableDataSource1DidSelectRowAtNot0() {
        var testMe: String?
        var colorMe: UIColor?
        let dataSource: SimpleDS5 = SimpleDS5.fallBack { textVM, _ in
            testMe = textVM.string
            colorMe = nil
        } cellTapped1: { colorVM, _ in
            testMe = nil
            colorMe = colorVM
        } cellTapped2: { textVM, _ in
            testMe = textVM.string
            colorMe = nil
        } cellTapped3: { colorVM, _ in
            testMe = nil
            colorMe = colorVM
        } cellTapped4: { textVM, _ in
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
        XCTAssertEqual(testMe, nil)
        XCTAssertEqual(colorMe, .red)
        dataSource.tableView(.init(), didSelectRowAt: .init(row: 0, section: 4))
    }

    /*
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
     section == 0 ? section0.tableViewViewForHeader(tableView) : nil
     }
     */
    func testTableDataSource1viewForHeaderInSection0() {
        let dataSource: SimpleDS5 = SimpleDS5.fallBack()
            // TableDS(section0: .fallBack { _, _ in })
        XCTAssertNil(dataSource.tableView(UITableView(), viewForHeaderInSection: 0))
        XCTAssertNil(dataSource.tableView(UITableView(), viewForHeaderInSection: 1))
        XCTAssertNil(dataSource.tableView(UITableView(), viewForHeaderInSection: 2))
        XCTAssertNil(dataSource.tableView(UITableView(), viewForHeaderInSection: 3))
        XCTAssertNil(dataSource.tableView(UITableView(), viewForHeaderInSection: 4))
    }

    /*
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
     section == 0 ? section0.tableViewHeightForHeaderInSection(tableView) : 0
     }
     */

    func testTableDataSource1heightForHeaderInSection() {
        let dataSource: SimpleDS5 = SimpleDS5.fallBack()
            // TableDS(section0: .fallBack { _, _ in })
        XCTAssertEqual(dataSource.tableView(UITableView(), heightForHeaderInSection: 0), 0)
        XCTAssertEqual(dataSource.tableView(UITableView(), heightForHeaderInSection: 1), 0)
        XCTAssertEqual(dataSource.tableView(UITableView(), heightForHeaderInSection: 2), 0)
        XCTAssertEqual(dataSource.tableView(UITableView(), heightForHeaderInSection: 3), 0)
        XCTAssertEqual(dataSource.tableView(UITableView(), heightForHeaderInSection: 4), 0)
    }

    /*
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     // first section count is 0
     section == 0 ? section0.tableViewNumberOfRows(tableView) : 0
     }
     */

    func testTableDataSource1numberOfRowsInSection0() {
        let dataSource: SimpleDS5 = SimpleDS5.fallBack()
            // TableDS(section0: .fallBack { _, _ in })
        XCTAssertEqual(dataSource.tableView(UITableView(), numberOfRowsInSection: 0), 1)
        XCTAssertEqual(dataSource.tableView(UITableView(), numberOfRowsInSection: 1), 3)
        XCTAssertEqual(dataSource.tableView(UITableView(), numberOfRowsInSection: 2), 1)
        XCTAssertEqual(dataSource.tableView(UITableView(), numberOfRowsInSection: 3), 3)
        XCTAssertEqual(dataSource.tableView(UITableView(), numberOfRowsInSection: 4), 1)
    }

    /*
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     indexPath.section == 0 ? section0.tableView(tableView, cellForRowAt: indexPath) :
     UITableViewCell()
     }
     */

    func testTableDataSource1cellForRowAt0() {
        let dataSource: SimpleDS5 = SimpleDS5.fallBack()
        let table = UITableMVVM<SimpleDS5>()
        dataSource.registerCells(tableView: table)
        XCTAssertTrue(dataSource.tableView(table, cellForRowAt: .init(item: 0, section: 0)) is CellTF)
        XCTAssertTrue(dataSource.tableView(table, cellForRowAt: .init(item: 0, section: 1)) is CellCV)
        XCTAssertTrue(dataSource.tableView(table, cellForRowAt: .init(item: 0, section: 2)) is CellTF)
        XCTAssertTrue(dataSource.tableView(table, cellForRowAt: .init(item: 0, section: 3)) is CellCV)
        XCTAssertTrue(dataSource.tableView(table, cellForRowAt: .init(item: 0, section: 4)) is CellTF)
    }

    func testOutsideBounds() {
        let dataSource: SimpleDS5 = SimpleDS5.fallBack()
        let table = UITableMVVM<SimpleDS5>()
        dataSource.registerCells(tableView: table)
        XCTAssertNotNil(dataSource.tableView(table, cellForRowAt: .init(item: 0, section: 5)))
        XCTAssertFalse(
            dataSource.tableView(table, cellForRowAt: .init(item: 0, section: 5)) is CellTF ||
                dataSource.tableView(table, cellForRowAt: .init(item: 0, section: 5)) is CellCV
        )
        XCTAssertEqual(dataSource.tableView(table, numberOfRowsInSection: 5), 0)
        XCTAssertEqual(dataSource.tableView(table, heightForHeaderInSection: 5), 0)
        XCTAssertNil(dataSource.tableView(table, viewForHeaderInSection: 5))
        // Not sure how to test `do {}`
        dataSource.tableView(table, didSelectRowAt: .init(row: 0, section: 5))
        XCTAssertEqual(dataSource.numberOfSections(in: table), 5)
    }
}
