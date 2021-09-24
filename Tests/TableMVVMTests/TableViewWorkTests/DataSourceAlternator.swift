//
//  File.swift
//  
//
//  Created by Scott Lydon on 9/23/21.
//

import XCTest
@testable import TableMVVM

class DataSourceAlternatorTests: XCTestCase {

    typealias Section1 = SectionWithoutHeader<OneRow<CellTF>>
    typealias Section2 = SectionWithoutHeader<OneRow<CellCV>>
    typealias TDS1 = TableDataSource1<Section1>
    typealias TDS2 = TableDataSource1<Section2>
    typealias DataSource = DataSourceAlternator<TDS1, TDS2>

    var dataSourceAlternator: DataSource {
        DataSource(
            dataSource1: TDS1(section0: .fallBack),
            dataSource2: TDS2(section0: .fallBack),
            alternatingLogic: { ds1, ds2 in
                ds1
            }
        )
    }

    func testRegisterCandidates() {
        let ds = dataSourceAlternator
        XCTAssertEqual(ds.registerCandidates.count, 2)
    }

    func testAddTable() {
        let ds = dataSourceAlternator
        let table = UITableView()
        ds.table = table
        XCTAssertEqual(table, ds.table)
    }

    func testFallBack() {
        let fallBack = DataSource.fallBack
        XCTAssertEqual(fallBack.dataSource1.section0.rows.item.string, "cats")
    }

    func testDefaultDatasources() {
        let ds = DataSource(alternatingLogic: nil)
        XCTAssertEqual(ds.dataSource1.section0.rows.item.string, "cats")
    }

    func testCurrentDataSource() {
        let ds = dataSourceAlternator
        XCTAssertEqual((ds.currentDataSource as? TDS1)?.section0.rows.item.string, TDS1.fallBack.section0.rows.item.string)
    }

    func testInit() {
        let ds = DataSource(alternatingLogic: nil)
        XCTAssertEqual(ds.dataSource1.section0.rows.item.string, "cats")
    }

    func testNumberOfSections() {
        let ds = dataSourceAlternator
        XCTAssertEqual(ds.numberOfSections(in: .init()), 1)
    }

    func testTableDidSelectRow() {
        let ds = dataSourceAlternator
        var wasTapped: Bool = false
        ds.dataSource1.section0.rows.tapped = { viewModel, indxPath in
            wasTapped = true
        }
        XCTAssertNoThrow(ds.tableView(.init(), didSelectRowAt: .zero))
        XCTAssertTrue(wasTapped)
    }

    func testViewForHeaderInSection() {
        let ds = dataSourceAlternator
        XCTAssertNil(ds.tableView(.init(), viewForHeaderInSection: .zero))
    }

    func testHeightForHeaderInSection() {
        let ds = dataSourceAlternator
        XCTAssertEqual(ds.tableView(.init(), heightForHeaderInSection: .zero), 0)
    }

    func testNumberOfRowsInSection() {
        let ds = dataSourceAlternator
        XCTAssertEqual(ds.tableView(.init(), numberOfRowsInSection: .zero), 1)
    }

    func testCellForRowAt() {
        let ds = dataSourceAlternator
        let table = UITableView()
        ds.registerCells(tableView: table)
        XCTAssertEqual((ds.tableView(table, cellForRowAt: .zero) as? CellTF)?.viewModel.string, "cats")
    }
}
