//
//  TableDataSourceTests.swift
//  TableViewWorkTests
//
//  Created by Scott Lydon on 9/15/21.
//

import XCTest
@testable import TableMVVM

class TableDataSource1Tests: XCTestCase {

    typealias DS1 = TableDataSource1<SectionNoHeader<ViewModelCell<ColorView>>>

    var dataSource: DS1 {
        .init(
            section0: .init(
                cellsViewModels: [.black, .red, .green],
                cellTapped: nil
            )
        )
    }

    func testTableDataSource1() {
        let dataSource = self.dataSource
        XCTAssertEqual(1, dataSource.numberOfSections(in: UITableView()))
        XCTAssertEqual(3, dataSource.tableView(UITableView(), numberOfRowsInSection: 0))
        XCTAssertEqual(0, dataSource.tableView(UITableView(), numberOfRowsInSection: 1))
        XCTAssertEqual(0, dataSource.tableView(UITableView(), numberOfRowsInSection: 2))
    }
}
