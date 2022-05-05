//
//  TestMiscelenious.swift
//  TableViewWorkTests
//
//  Created by Scott Lydon on 9/19/21.
//

import XCTest
@testable import TableMVVM

class TestMisc: XCTestCase {

    func testcomposesRows() {
        let headerText = "Header me!"
        let section: Section0 = .init(
            header: .init(viewModel: .init(string: headerText)),
            rows: .init(
                item: .cyan,
                tapped: { _, _ in }
            )
        )
        let table = UITableView()
        section.registerHeader(tableView: table)
        XCTAssertNotNil(section.tableViewViewForHeader(table) as? HeaderTF)
        XCTAssertEqual((section.tableViewViewForHeader(table) as? HeaderTF)?.viewModel.string, headerText)
        XCTAssertEqual(section.tableViewHeightForHeaderInSection(table), -1)
    }

    func testReloadNoCrash() {
        let tableView = UITableView()
        tableView.reload(on: DispatchQueueMock())
    }

    func testUITableViewGenericCellWhenNoViewModel() {
        let tableView = UITableView()
        tableView.register(CellTF.self, forCellReuseIdentifier: CellTF.className)
        let cell = tableView.dequeueCell(
            for: .zero,
            cell: CellTF(),
            viewModel: nil
        )
        XCTAssertFalse(cell is CellTF)
    }

    func testAlternatesRows() {
        var rowsExample: RowAlternator2<OneRow<CellCV>, OneRow<CellTF>> = .init(
            rows1: .init(item: .green, tapped: { _, _ in }),
            rows2: .init(item: .init(string: "Womp"), tapped: { _, _ in })
        ) { _, secondRow in
            secondRow
        }
        XCTAssertEqual(rowsExample.count, 1)
        XCTAssertEqual(rowsExample.tableViewNumberOfRows(.init()), 1)
        let table = UITableView()
        rowsExample.registerCells(tableView: table)
        XCTAssertEqual(
            (rowsExample.tableView(table, cellForRowAt: .zero) as? CellTF)?.viewModel.string,
            "Womp"
        )

        rowsExample.alternatingLogic = nil
        XCTAssertEqual(
            (rowsExample.tableView(table, cellForRowAt: .zero) as? CellCV)?.viewModel,
            .green
        )
        XCTAssertEqual(rowsExample.currentRows.count, 1)
    }

    // swiftlint:disable all
    func testSectionAlternator() {
    // swiftlint:enable all
        typealias FirstSection = SectionWithoutHeader<OneRow<CellTF>>
        typealias SecondSection = SectionWithoutHeader<OneRow<CellCV>>
        var text: String?
        var indexPath: IndexPath?
        var color: UIColor?
        var sectionAlternator2: SectionAlternator2<FirstSection, SecondSection> = .init(
            section1: .init(
                rows: .init(
                    item: .init(string: "text"),
                    tapped: { textVM, indxPath in
                        text = textVM.string
                        indexPath = indxPath
                        color = nil
                    }
                )
            ),
            section2: .init(
                rows: .init(
                    item: .red, tapped: { colorVM, indxPath in
                        text = nil
                        indexPath = indxPath
                        color = colorVM
                    }
                )
            )
        ) { firstSection, _ in
            firstSection
        }
        XCTAssertEqual(text, nil)
        XCTAssertEqual(indexPath, nil)
        XCTAssertEqual(color, nil)
        sectionAlternator2.currentSection.tableViewDidSelectRowAt(.init(), didSelectRowAt: .zero)
        XCTAssertEqual(text, "text")
        XCTAssertEqual(indexPath, .zero)
        XCTAssertEqual(color, nil)
        sectionAlternator2.alternatingLogic = { _, secondSection in
            secondSection
        }
        sectionAlternator2.currentSection.tableViewDidSelectRowAt(.init(), didSelectRowAt: .zero)
        XCTAssertEqual(text, nil)
        XCTAssertEqual(indexPath, .zero)
        XCTAssertEqual(color, .red)
        XCTAssertEqual(sectionAlternator2.tableViewNumberOfRows(.init()), 1)
        XCTAssertEqual(sectionAlternator2.tableViewViewForHeader(.init()), nil)
        XCTAssertEqual(sectionAlternator2.tableViewHeightForHeaderInSection(.init()), 0)
        let table = UITableView()
        sectionAlternator2.registerCells(tableView: table)
        XCTAssertEqual(
            (sectionAlternator2.tableView(table, cellForRowAt: .zero) as? CellCV)?.viewModel,
            .red
        )
        sectionAlternator2.alternatingLogic = nil
        XCTAssertEqual(
            (sectionAlternator2.currentSection as? SectionWithoutHeader<OneRow<CellTF>>)?.rows.item.string,
            "text"
            )

    }

    func testTableMVVM() {

        let viewModel: UITableMVVM<TableDS>.ViewModel = .init(
            section0: .init(
                rows: .init(
                    items: [.init(string: "1"), .init(string: "2"), .init(string: "3")],
                    tapped: { _, _ in }
                )
            )
        )
        let table: UITableMVVM<TableDS> = .init(viewModel: viewModel)
        XCTAssertEqual(table.frame, .zero)
        XCTAssertEqual(table.viewModel, viewModel)
        XCTAssertEqual(table.viewModel?.table, table)
        XCTAssertNotNil(table.delegate)
        XCTAssertNotNil(table.dataSource)
        XCTAssertEqual(table.delegate as? UITableMVVM<TableDS>.ViewModel, viewModel)
        XCTAssertEqual(table.dataSource as? UITableMVVM<TableDS>.ViewModel, viewModel)
        XCTAssertNotNil(table.viewModel?.tableView(table, cellForRowAt: .zero))
        XCTAssertNotNil(table.viewModel?.tableView(table, cellForRowAt: .zero) as? CellTF)
        XCTAssertEqual(
            (table.viewModel?.tableView(table, cellForRowAt: .zero) as? CellTF)?.viewModel.string,
            "1"
        )
        let items = table.viewModel?.section0.rows.items.map(\.string)
        XCTAssertEqual(items, ["1", "2", "3"])
        table.viewModel = .init(section0: .init())
        XCTAssertEqual(
            table.viewModel?.section0.rows.items.map(\.string),
            TableDS(section0: .init()).section0.rows.items.map(\.string)
        )
        XCTAssertEqual(
            table.presentationViewModel?.section0.rows.items.map(\.string),
            TableDS(section0: .init()).section0.rows.items.map(\.string)
        )
        XCTAssertNil(UITableMVVM<TableDS>.init(coder: .init()))
    }

    func testHasHeader() {
        let table = UITableView()
        let header: Header<HeaderTF> = .init(viewModel: .init(string: "bushes"))
        XCTAssertNil((header.tableViewViewForHeader(.init()) as? TextView)?.viewModel.string)
        XCTAssertEqual(header.tableViewHeightForHeaderInSection(.init()), -1)
        header.registerHeader(tableView: table)
        XCTAssertNotNil(header.tableViewViewForHeader(table))
        XCTAssertNotNil(header.tableViewViewForHeader(table) as? HeaderTF)
        XCTAssertEqual((header.tableViewViewForHeader(table) as? HeaderTF)?.viewModel.string, "bushes")
    }

    func testHeaderFooter() {
        let vm: HeaderFooter<TextView>.ViewModel = .init(string: "dogs")
        XCTAssertEqual(vm.string, "dogs")
        let headerFooter: HeaderFooter<TextView> = .init(viewModel: vm)
        XCTAssertEqual(headerFooter.view.viewModel.string, "dogs")
        let headerFooter1: HeaderTF = .init()
        XCTAssertEqual(headerFooter1.view.viewModel.string, "cats")
        XCTAssertEqual(HeaderTF.className, "TextView")
        XCTAssertEqual(headerFooter.subviews.first?.backgroundColor, .clear)
     //   XCTAssertNotNil(headerFooter.subviews.first?.subviews.first)
      //   XCTAssertEqual(headerFooter.subviews.first?.subviews.first?.backgroundColor, .clear)
        XCTAssertGreaterThan(headerFooter.contentView.subviews.count, 0)
    }

    func testComposesRowsCount() {
        let sectionWithout: SectionWithoutHeader<OneRow<CellTF>> = .init(
            rows: .init(
                item: .init(string: "cell"),
                tapped: { _, _ in }
            )
        )
        XCTAssertEqual(sectionWithout.count, 1)
    }

    func testComposesRowsCountmultiple() {
        var sectionWith: SectionWithoutHeader<Rows<CellCV>> = .init(
            rows: .init(
                items: [.red, .orange, .yellow],
                tapped: nil
            )
        )
        XCTAssertEqual(sectionWith.count, 3)
        sectionWith.rows.items = []
        XCTAssertEqual(sectionWith.count, 0)
        sectionWith.rows.items.append(.blue)
        sectionWith.rows.items.append(.gray)
        XCTAssertEqual(sectionWith.count, 2)
    }

    func testHasCellsCellsForRowAt() {
        let table = UITableView()
        let section: Section<HeaderTF, CellTF> = .init(
            headerViewModel: .init(string: "My Header"),
            cellsViewModels: [
                .init(string: "1"),
                .init(string: "2"),
                .init(string: "3"),
                .init(string: "4")
            ]
        ) { _, _ in }
        section.registerCells(tableView: table)
        XCTAssertEqual(
            (section.tableView(table, cellForRowAt: .zero) as? CellTF)?.viewModel.string,
            CellTF(viewModel: .init(string: "1")).viewModel.string
        )
    }
}
