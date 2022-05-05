//
//  SectionNoHeader.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/11/21.
//

import UIKit

/// Definition:
/// ```
/// public struct SectionNoHeader<Cell>: HasCells, HasInit, HasNoHeader`
///    where Cell: UITableViewCell,
///    Cell: HasViewModel
/// ```
public struct SectionNoHeader<Cell>: HasCells, HasFallBack, HasNoHeader, HasCount
where Cell: UITableViewCell,
      Cell: HasViewModel {

    public var cellsViewModels: [Cell.ViewModel] = []
    public var cellTapped: CellTapAction?
    public init(
        cellsViewModels: [Cell.ViewModel] = [],
        cellTapped: CellTapAction? = nil
    ) {
        self.cellsViewModels = cellsViewModels
        self.cellTapped = cellTapped
    }
    public static var fallBack: Self { .init() }
}
