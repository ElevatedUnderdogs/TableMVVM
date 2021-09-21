//
//  TestDataSource3.swift
//  TableViewWorkTests
//
//  Created by Scott Lydon on 9/19/21.
//

import XCTest
@testable import TableMVVM

typealias TextSection = SectionNoHeader<CellTF>
typealias ColorSection = SectionNoHeader<CellCV>

extension TextSection {

    typealias TextCellTapAction = ((ViewModelCell<TextView>.ViewModel, IndexPath) -> Void)

    static func fallBack(cellTapped: TextCellTapAction? = nil) -> TextSection {
        TextSection(
            cellsViewModels: [.init(string: "hello")],
            cellTapped: cellTapped
        )
    }
}

extension ColorSection {

    typealias CellTapAction = ((ViewModelCell<ColorView>.ViewModel, IndexPath) -> Void)

    static func fallBack(cellTapped: CellTapAction? = nil) -> ColorSection {
        ColorSection(
            cellsViewModels: [.red, .orange, .yellow],
            cellTapped: cellTapped
        )
    }
}

typealias SimpleDS1 = TableDataSource1<TextSection>
typealias SimpleDS2 = TableDataSource2<TextSection, ColorSection>
typealias SimpleDS3 = TableDataSource3<TextSection, ColorSection, TextSection>
typealias SimpleDS4 = TableDataSource4<TextSection, ColorSection, TextSection, ColorSection>
typealias SimpleDS5 = TableDataSource5<TextSection, ColorSection, TextSection, ColorSection, TextSection>
typealias SimpleDS6 = TableDataSource6<TextSection, ColorSection, TextSection, ColorSection, TextSection, ColorSection>
typealias SimpleDS7 = TableDataSource7<
    TextSection, ColorSection, TextSection, ColorSection, TextSection, ColorSection, TextSection
>
typealias SimpleDS8 = TableDataSource8<
    TextSection, ColorSection, TextSection, ColorSection, TextSection, ColorSection, TextSection, ColorSection
>

extension SimpleDS4 {

    static func fallBack(
        cellTapped0: TextSection.TextCellTapAction? = nil,
        cellTapped1: ColorSection.CellTapAction? = nil,
        cellTapped2: TextSection.TextCellTapAction? = nil,
        cellTapped3: ColorSection.CellTapAction? = nil
    ) -> SimpleDS4 {
        SimpleDS4(
            section0: .fallBack(cellTapped: cellTapped0),
            section1: .fallBack(cellTapped: cellTapped1),
            section2: .fallBack(cellTapped: cellTapped2),
            section3: .fallBack(cellTapped: cellTapped3)
        )
    }
}

/// Tests to efficiently reach multiple components
class TestDataSource4: XCTestCase {

    // MARK: - TableDataSource1
    func testTableDataSource1ReloadData() {
        let dataSource: SimpleDS4 = SimpleDS4.fallBack()
        dataSource.queue = DispatchQueueMock()
        dataSource.section0 = .init()
        dataSource.section1 = .init()
        dataSource.section2 = .init()
        dataSource.section3 = .init()
    }

    func testTableDataSource1DidSelectRowAtNot0() {
        var testMe: String?
        var colorMe: UIColor?
        let dataSource: SimpleDS4 = SimpleDS4.fallBack { textVM, _ in
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

    /*
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
     section == 0 ? section0.tableViewViewForHeader(tableView) : nil
     }
     */
    func testTableDataSource1viewForHeaderInSection0() {
        let dataSource: SimpleDS4 = SimpleDS4.fallBack()
            // TableDS(section0: .fallBack { _, _ in })
        XCTAssertNil(dataSource.tableView(UITableView(), viewForHeaderInSection: 0))
        XCTAssertNil(dataSource.tableView(UITableView(), viewForHeaderInSection: 1))
        XCTAssertNil(dataSource.tableView(UITableView(), viewForHeaderInSection: 2))
        XCTAssertNil(dataSource.tableView(UITableView(), viewForHeaderInSection: 3))
    }

    /*
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
     section == 0 ? section0.tableViewHeightForHeaderInSection(tableView) : 0
     }
     */

    func testTableDataSource1heightForHeaderInSection() {
        let dataSource: SimpleDS4 = SimpleDS4.fallBack()
            // TableDS(section0: .fallBack { _, _ in })
        XCTAssertEqual(dataSource.tableView(UITableView(), heightForHeaderInSection: 0), 0)
        XCTAssertEqual(dataSource.tableView(UITableView(), heightForHeaderInSection: 1), 0)
        XCTAssertEqual(dataSource.tableView(UITableView(), heightForHeaderInSection: 2), 0)
        XCTAssertEqual(dataSource.tableView(UITableView(), heightForHeaderInSection: 3), 0)
    }

    /*
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     // first section count is 0
     section == 0 ? section0.tableViewNumberOfRows(tableView) : 0
     }
     */

    func testTableDataSource1numberOfRowsInSection0() {
        let dataSource: SimpleDS4 = SimpleDS4.fallBack()
            // TableDS(section0: .fallBack { _, _ in })
        XCTAssertEqual(dataSource.tableView(UITableView(), numberOfRowsInSection: 0), 1)
        XCTAssertEqual(dataSource.tableView(UITableView(), numberOfRowsInSection: 1), 3)
        XCTAssertEqual(dataSource.tableView(UITableView(), numberOfRowsInSection: 2), 1)
        XCTAssertEqual(dataSource.tableView(UITableView(), numberOfRowsInSection: 3), 3)
    }

    /*
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     indexPath.section == 0 ? section0.tableView(tableView, cellForRowAt: indexPath) :
     UITableViewCell()
     }
     */

    func testTableDataSource1cellForRowAt0() {
        let dataSource: SimpleDS4 = SimpleDS4.fallBack()
        let table = TableMVVM<SimpleDS4>()
        dataSource.registerCells(tableView: table)
        XCTAssertTrue(dataSource.tableView(table, cellForRowAt: .init(item: 0, section: 0)) is CellTF)
        XCTAssertTrue(dataSource.tableView(table, cellForRowAt: .init(item: 0, section: 1)) is CellCV)
        XCTAssertTrue(dataSource.tableView(table, cellForRowAt: .init(item: 0, section: 2)) is CellTF)
        XCTAssertTrue(dataSource.tableView(table, cellForRowAt: .init(item: 0, section: 3)) is CellCV)
    }

    func testOutsideBounds() {
        let dataSource: SimpleDS4 = SimpleDS4.fallBack()
        let table = TableMVVM<SimpleDS4>()
        dataSource.registerCells(tableView: table)
        XCTAssertNotNil(dataSource.tableView(table, cellForRowAt: .init(item: 0, section: 4)))
        XCTAssertFalse(
            dataSource.tableView(table, cellForRowAt: .init(item: 0, section: 4)) is CellTF ||
                dataSource.tableView(table, cellForRowAt: .init(item: 0, section: 4)) is CellCV
        )
        XCTAssertEqual(dataSource.tableView(table, numberOfRowsInSection: 4), 0)
        XCTAssertEqual(dataSource.tableView(table, heightForHeaderInSection: 4), 0)
        XCTAssertNil(dataSource.tableView(table, viewForHeaderInSection: 4))
        // Not sure how to test `do {}`
        dataSource.tableView(table, didSelectRowAt: .init(row: 0, section: 4))
        XCTAssertEqual(dataSource.numberOfSections(in: table), 4)
    }
}
