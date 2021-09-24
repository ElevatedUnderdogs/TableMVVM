//
//  TypeAliasesAndFallbacks.swift
//  TableViewWorkTests
//
//  Created by Scott Lydon on 9/19/21.
//

import XCTest
@testable import TableMVVM

typealias HeaderTF = HeaderFooter<TextView>
typealias HeaderCV = HeaderFooter<ColorView>
typealias CellTF = ViewModelCell<TextView>
typealias CellCV = ViewModelCell<ColorView>

typealias Section0 = SectionWithRowsHeader<Header<HeaderTF>, OneRow<CellCV>>
typealias Section1 = Section<HeaderTF, CellCV>
typealias Section2 = SectionAlternator2<Section0, Section1>
typealias Section3 = SectionWithoutHeader<RowAlternator2<OneRow<CellTF>, OneRow<CellCV>>>

typealias My4Table = TableDataSource4<Section0, Section1, Section2, Section3>

func useSection0(
    tapColor: OneRow<ViewModelCell<ColorView>>.CellTapAction?
) -> Section0 {
    Section0(
        header: .init(viewModel: .init(string: "HeaderBoo")),
        rows: .init(item: .blue, tapped: tapColor)
    )
}

func useSection1(
    section1CellTap: Section<HeaderFooter<TextView>, ViewModelCell<ColorView>>.CellTapAction?
) -> Section1 {
    Section1(
        headerViewModel: .init(string: "wowee"),
        cellsViewModels: [.red, .orange, .yellow],
        cellTapped: section1CellTap
    )
}

func useSection3(
    oneRowTap: OneRow<ViewModelCell<TextView>>.CellTapAction?,
    tappedAction: OneRow<CellCV>.CellTapAction?
) -> Section3 {
    Section3(
        rows: .init(
            rows1: .init(
                item: .init(string: "wowza"),
                tapped: oneRowTap
            ),
            rows2: .init(item: .brown, tapped: tappedAction
            ),
            alternatingLogic: { textRow, colorRow in
                if textRow.item.string == "cow" {
                    return colorRow
                } else {
                    return textRow
                }
            }
        )
    )
}

extension My4Table {

    static func fallBack(
        tapColor: OneRow<ViewModelCell<ColorView>>.CellTapAction? = nil,
        section1CellTap: Section<HeaderFooter<TextView>, ViewModelCell<ColorView>>.CellTapAction? = nil,
        oneRowTap: OneRow<ViewModelCell<TextView>>.CellTapAction? = nil ,
        tappedAction: OneRow<CellCV>.CellTapAction? = nil
    ) -> My4Table {
        My4Table(
            section0: useSection0(tapColor: tapColor),
            section1: useSection1(section1CellTap: section1CellTap),
            section2: Section2(
                section1: useSection0(tapColor: tapColor),
                section2: useSection1(section1CellTap: section1CellTap),
                alternatingLogic: { firstSection, secondSection in
                    if firstSection.rows.item == .blue {
                        return firstSection
                    } else {
                        return secondSection
                    }
                }
            ),
            section3: useSection3(oneRowTap: oneRowTap, tappedAction: tappedAction)
        )
    }
}
