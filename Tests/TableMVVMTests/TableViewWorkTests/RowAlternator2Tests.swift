//
//  RowAlternator2Tests.swift
//  
//
//  Created by Scott Lydon on 9/24/21.
//

import XCTest
@testable import TableMVVM

class RowAlternator2Tests: XCTestCase {

    func testInitForIsEmpty() {
        var rowAlternator: RowAlternator2<Rows<CellTF>, Rows<CellTF>> = .init(
            rows1: .init(
                items: [],
                tapped: nil),
            rows2: .init(
                items: [.init(string: "cats")],
                tapped: nil)
        )
        // if it goes to the nil default, it will have the row count as 0
        XCTAssertEqual(rowAlternator.currentRows.count, 1)
        rowAlternator.rows1.items = [.init(string: "dog"), .init(string: "cat")]
        // switched to row1 because its not empty.
        XCTAssertEqual(rowAlternator.currentRows.count, 2)
    }

    func testInitDataSource() {
        let alternator: DataSourceAlternator<
            TableDataSource1<SectionWithoutHeader<Rows<CellTF>>>,
            TableDataSource1<SectionWithoutHeader<Rows<CellTF>>>
        > = DataSourceAlternator(
            dataSource1: .init(
                section0: .init(
                    rows: .init(
                        items: [],
                        tapped: nil
                    )
                )
            ), dataSource2: .init(
                section0: .init(
                    rows: .init(
                        items: [.init(string: "cows"), .init(string: "cat")],
                        tapped: nil
                    )
                )
            )
        )
        XCTAssertEqual(
            (alternator.currentDataSource as? TableDataSource1<SectionWithoutHeader<Rows<CellTF>>>)?.section0.count,
            2
        )
        alternator.dataSource1.section0.rows.items = [.init(string: "cats")]
        XCTAssertEqual(
            (alternator.currentDataSource as? TableDataSource1<SectionWithoutHeader<Rows<CellTF>>>)?.section0.count,
            1
        )
    }

    
}
