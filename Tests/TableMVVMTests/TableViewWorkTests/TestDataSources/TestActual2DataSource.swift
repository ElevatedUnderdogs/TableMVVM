//
//  TestActual2DataSource.swift
//  TableViewWorkTests
//
//  Created by Scott Lydon on 9/19/21.
//
import XCTest
@testable import TableMVVM

extension SimpleDS2 {

    static func fallBack(
        cellTapped0: TextSection.TextCellTapAction? = nil,
        cellTapped1: ColorSection.CellTapAction? = nil
    ) -> SimpleDS2 {
        SimpleDS2(
            section0: .fallBack(cellTapped: cellTapped0),
            section1: .fallBack(cellTapped: cellTapped1)
        )
    }
}

/// Tests to efficiently reach multiple components
class TestDataSource2Actual: XCTestCase {

    // MARK: - TableDataSource1
    func testTableDataSource1ReloadData() {
        let dataSource: SimpleDS2 = SimpleDS2.fallBack()
        dataSource.queue = DispatchQueueMock()
        dataSource.section0 = .init()
        dataSource.section1 = .init()
    }

    func testTableDataSource1DidSelectRowAtNot0() {
        var testMe: String?
        var colorMe: UIColor?
        let dataSource: SimpleDS2 = SimpleDS2.fallBack { textVM, _ in
            testMe = textVM.string
            colorMe = nil
        } cellTapped1: { colorVM, _ in
            testMe = nil
            colorMe = colorVM
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
    }
    /*
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
     section == 0 ? section0.tableViewViewForHeader(tableView) : nil
     }
     */
    func testTableDataSource1viewForHeaderInSection0() {
        let dataSource: SimpleDS2 = SimpleDS2.fallBack()
            // TableDS(section0: .fallBack { _, _ in })
        XCTAssertNil(dataSource.tableView(UITableView(), viewForHeaderInSection: 0))
        XCTAssertNil(dataSource.tableView(UITableView(), viewForHeaderInSection: 1))
    }

    /*
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
     section == 0 ? section0.tableViewHeightForHeaderInSection(tableView) : 0
     }
     */

    func testTableDataSource1heightForHeaderInSection() {
        let dataSource: SimpleDS2 = SimpleDS2.fallBack()
            // TableDS(section0: .fallBack { _, _ in })
        XCTAssertEqual(dataSource.tableView(UITableView(), heightForHeaderInSection: 0), 0)
        XCTAssertEqual(dataSource.tableView(UITableView(), heightForHeaderInSection: 1), 0)
    }

    /*
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     // first section count is 0
     section == 0 ? section0.tableViewNumberOfRows(tableView) : 0
     }
     */

    func testTableDataSource1numberOfRowsInSection0() {
        let dataSource: SimpleDS2 = SimpleDS2.fallBack()
            // TableDS(section0: .fallBack { _, _ in })
        XCTAssertEqual(dataSource.tableView(UITableView(), numberOfRowsInSection: 0), 1)
        XCTAssertEqual(dataSource.tableView(UITableView(), numberOfRowsInSection: 1), 3)
    }

    /*
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     indexPath.section == 0 ? section0.tableView(tableView, cellForRowAt: indexPath) :
     UITableViewCell()
     }
     */

    func testTableDataSource1cellForRowAt0() {
        let dataSource: SimpleDS2 = SimpleDS2.fallBack()
        let table = UITableMVVM<SimpleDS2>()
        dataSource.registerCells(tableView: table)
        XCTAssertTrue(dataSource.tableView(table, cellForRowAt: .init(item: 0, section: 0)) is CellTF)
        XCTAssertTrue(dataSource.tableView(table, cellForRowAt: .init(item: 0, section: 1)) is CellCV)
    }

    func testOutsideBounds() {
        let dataSource: SimpleDS2 = SimpleDS2.fallBack()
        let table = UITableMVVM<SimpleDS2>()
        dataSource.registerCells(tableView: table)
        XCTAssertNotNil(dataSource.tableView(table, cellForRowAt: .init(item: 0, section: 2)))
        XCTAssertFalse(
            dataSource.tableView(table, cellForRowAt: .init(item: 0, section: 2)) is CellTF ||
                dataSource.tableView(table, cellForRowAt: .init(item: 0, section: 2)) is CellCV
        )
        XCTAssertEqual(dataSource.tableView(table, numberOfRowsInSection: 2), 0)
        XCTAssertEqual(dataSource.tableView(table, heightForHeaderInSection: 2), 0)
        XCTAssertNil(dataSource.tableView(table, viewForHeaderInSection: 2))
        // Not sure how to test `do {}`
        dataSource.tableView(table, didSelectRowAt: .init(row: 0, section: 2))
        XCTAssertEqual(dataSource.numberOfSections(in: table), 2)
    }
}
