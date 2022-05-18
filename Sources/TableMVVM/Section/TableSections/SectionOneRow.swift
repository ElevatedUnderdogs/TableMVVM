//
//  SectionOneRow.swift
//  
//
//  Created by Scott Lydon on 5/17/22.
//

import UIKit

/// Definition:
/// ```
/// public struct SectionOneRow<Cell>: HasCells, HasFallBack, HasNoHeader, HasCount
/// where Cell: UITableViewCell,
///      Cell: HasViewModel,
///      Cell.ViewModel: HasFallBack
/// ```
public struct SectionOneRow<Cell>: HasCells, HasFallBack, HasNoHeader, HasCount
where Cell: UITableViewCell,
      Cell: HasViewModel,
      Cell.ViewModel: HasFallBack {

    public var cellsViewModels: [Cell.ViewModel] {
        [cellViewModel]
    }

    public var cellViewModel: Cell.ViewModel = .fallBack

    public var cellTapped: CellTapAction?
    public init(
        cellViewModel: Cell.ViewModel = .fallBack,
        cellTapped: CellTapAction? = nil
    ) {
        self.cellViewModel = cellViewModel
        self.cellTapped = cellTapped
    }
    public static var fallBack: Self { .init() }
}
