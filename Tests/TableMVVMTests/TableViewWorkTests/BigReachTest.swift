//
//  BigReachTest.swift
//  TableViewWorkTests
//
//  Created by Scott Lydon on 9/16/21.
//

import XCTest
@testable import TableMVVM
import UIKit

typealias FirstAlternatingSection = Section<HeaderFooter<TextView>, ViewModelCell<ColorView>>

typealias Header1 = Header<HeaderFooter<TextView>>
typealias Row1 = OneRow<ViewModelCell<ColorView>>
typealias SecondAlternatingSection = SectionWithRowsHeader<Header1, Row1>

typealias CombinedSection = SectionAlternator2<FirstAlternatingSection, SecondAlternatingSection>

typealias NextSection = SectionWithRowsHeader<Header1, Rows<ViewModelCell<ColorView>>>

typealias DataSource = TableDataSource2<CombinedSection, NextSection>

/// Tests to efficiently reach multiple components
class BigReachTests: XCTestCase {

    /// Test big reach
    func testContainerInit() {
        var firstVM: ViewModelCell<ColorView>.ViewModel?
        var firstIndex: IndexPath?

        var secondVM: ViewModelCell<ColorView>.ViewModel?
        var secondIndexPath: IndexPath?

        var thirdVM: ViewModelCell<ColorView>.ViewModel?
        var thirdIndexPath: IndexPath?

        let abc: DataSource = DataSource(
            section0: CombinedSection(
                section1: FirstAlternatingSection(
                    headerViewModel: .init(string: "firstHeader"),
                    cellsViewModels: [.red, .yellow, .green],
                    cellTapped: { colorViewModel, indexPath in
                        firstVM = colorViewModel
                        firstIndex = indexPath
                    }
                ),
                section2: SecondAlternatingSection(
                    header: .init(headerViewModel: .init(string: "dogs")),
                    rows: .init(item: .cyan, tapped: { colorVM, indexPath in
                        secondVM = colorVM
                        secondIndexPath = indexPath
                    })
                ),
                alternatingLogic: { firstSection, _ in
                    firstSection
                }
            ),
            section1: NextSection(
                header: Header1(headerViewModel: .init(string: "wow")),
                rows: .init(items: [.black, .red, .yellow], tapped: { colorViewModel, indexPath in
                    thirdVM = colorViewModel
                    thirdIndexPath = indexPath
                })
            )
        )
        XCTAssertNil(firstVM)
        XCTAssertNil(firstIndex)

        XCTAssertNil(secondVM)
        XCTAssertNil(secondIndexPath)

        XCTAssertNil(thirdVM)
        XCTAssertNil(thirdIndexPath)

        XCTAssertNil(abc.table)
        abc.set(table: UITableView())
        XCTAssertNotNil(abc.table)
        XCTAssertEqual(abc.numberOfSections(in: UITableView()), 2)
    }
}
