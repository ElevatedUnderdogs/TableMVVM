//
//  TestDataSource1.swift
//  TableViewWorkTests
//
//  Created by Scott Lydon on 9/18/21.
//

import XCTest
@testable import TableMVVM

/// Tests to efficiently reach multiple components
class TestDataSource1: XCTestCase {

    // MARK: - TableDataSource1
    func testTableDataSource1ReloadData() {
        let section = SectionDS.fallBack { _, _ in }
        let dataSource: TableDS = TableDS(section0: section)
        dataSource.section0 = section
    }

    func testTableDataSource1DidSelectRowAtNot0() {
        var testMe: String?
        let dataSource: TableDS = TableDS(section0: .fallBack { textVM, _ in
            testMe = textVM.string
        })
        dataSource.tableView(UITableView(), didSelectRowAt: IndexPath(row: 0, section: 3))
        XCTAssertNil(testMe)
    }

    func testTableDataSource1DidSelectRowAt0() {
        var testMe: String?
        var indexPath: IndexPath?
        let dataSource: TableDS = TableDS(section0: .fallBack { textVM, indxPath in
            testMe = textVM.string
            indexPath = indxPath
        })
        dataSource.tableView(UITableView(), didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(testMe, "Hi")
        XCTAssertEqual(indexPath, indexPath)
    }

    func testTableDataSource1DidSelectRowAt0Row1() {
        var testMe: String?
        var indexPath: IndexPath?
        let dataSource: TableDS = TableDS(section0: .fallBack { textVM, indxPath in
            testMe = textVM.string
            indexPath = indxPath
        })
        dataSource.tableView(UITableView(), didSelectRowAt: IndexPath(row: 1, section: 0))
        XCTAssertEqual(testMe, "Wow")
        XCTAssertEqual(indexPath, .init(row: 1, section: 0))
    }

    /*
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         section == 0 ? section0.tableViewViewForHeader(tableView) : nil
     }
     */
    func testTableDataSource1viewForHeaderInSection0() {
        let dataSource: TableDS = TableDS(section0: .fallBack { _, _ in })
        let view = dataSource.tableView(UITableView(), viewForHeaderInSection: 1)
        XCTAssertNil(view)
    }

    func testTableDataSource1viewForHeaderInSectionNot0() {
        let dataSource: TableDS = TableDS(section0: .fallBack { _, _ in })
        let view = dataSource.tableView(UITableView(), viewForHeaderInSection: 0)
        XCTAssertNil(view) // NoHeader Section
    }

    /*
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         section == 0 ? section0.tableViewHeightForHeaderInSection(tableView) : 0
     }
     */

    func testTableDataSource1heightForHeaderInSection0() {
        let dataSource: TableDS = TableDS(section0: .fallBack { _, _ in })
        let headerHeight = dataSource.tableView(.init(), heightForHeaderInSection: 0)
        XCTAssertEqual(headerHeight, 0)
    }

    func testTableDataSource1heightForHeaderInSectionNot0() {
        let dataSource: TableDS = TableDS(section0: .fallBack { _, _ in })
        let headerHeight = dataSource.tableView(.init(), heightForHeaderInSection: 1)
        XCTAssertEqual(headerHeight, 0)
    }

    /*
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         // first section count is 0
         section == 0 ? section0.tableViewNumberOfRows(tableView) : 0
     }
     */

    func testTableDataSource1numberOfRowsInSection0() {
        let dataSource: TableDS = TableDS(section0: .fallBack { _, _ in })
        let numberOfRows: Int = dataSource.tableView(.init(), numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, 2)
    }

    func testTableDataSource1numberOfRowsInSectionNot0() {
        let dataSource: TableDS = TableDS(section0: .fallBack { _, _ in })
        let numberOfRows: Int = dataSource.tableView(.init(), numberOfRowsInSection: 1)
        XCTAssertEqual(numberOfRows, 0)
    }

    /*
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         indexPath.section == 0 ? section0.tableView(tableView, cellForRowAt: indexPath) :
             UITableViewCell()
     }
     */

    func testTableDataSource1cellForRowAt0() {
        let dataSource: TableDS = TableDS(section0: .fallBack { _, _ in })
        let table = TableMVVM<TableDS>()
        dataSource.registerCells(tableView: table)
        let cell = dataSource.tableView(table, cellForRowAt: .init(row: 0, section: 0))
        XCTAssertTrue(cell is ViewModelCell<TextView>)
    }

    func testTableDataSource1cellForRowAtNot0Section() {
        let dataSource: TableDS = TableDS(section0: .fallBack { _, _ in })
        let cell = dataSource.tableView(.init(), cellForRowAt: .init(row: 0, section: 1))
        XCTAssertFalse(cell is ViewModelCell<TextView>)
    }

    /*

     func registerCells(tableView: UITableView) {
         section0.registerCells(tableView: tableView)
     }
     */

    func testTableDataSource1registerCellsNoCrash() {
        let dataSource: TableDS = TableDS(section0: .fallBack { _, _ in })
        dataSource.registerCells(tableView: .init())
        XCTAssertEqual(dataSource.section0.rows.count, 2)
    }

    func testSectionCount() {
        var section = Section<HeaderFooter<ColorView>, ViewModelCell<TextView>>()
        section.cellsViewModels = [.init(string: "dogs"), .init(string: "cats")]
        XCTAssertEqual(section.count, 2)
    }

    // MARK: - ColorViewTest
    func testColorViewModel() {
        let section = ColorView()
        section.viewModel = .black
        XCTAssertEqual(section.viewModel, .black)
    }
}

typealias SectionDS = SectionWithoutHeader<Rows<ViewModelCell<TextView>>>
typealias TableDS = TableDataSource1<SectionDS>

extension SectionDS {

    static func fallBack(
        action: @escaping ((TextView.ViewModel, IndexPath) -> Void)
    ) -> SectionDS {
        SectionWithoutHeader(
            rows: Rows(
                items: [.init(string: "Hi"), .init(string: "Wow")],
                tapped: { textViewModel, indexPath in
                    action(textViewModel, indexPath)
                }
            )
        )
    }
}
