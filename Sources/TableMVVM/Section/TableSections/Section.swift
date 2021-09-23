//
//  Section.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/11/21.
//

import UIKit

/// Header could be `HeaderFooter`
/// Cell could be: `ViewModelCell`
/// Definition: 
/// ```
///     public struct Section<Header, Cell>: HasCells, HasInit, HasHeader
///     where Header: UITableViewHeaderFooterView,
///           Header: HasViewModel,
///           Header.ViewModel: HasInit,
///           Cell: UITableViewCell,
///           Cell: HasViewModel {
/// ```
public struct Section<Header, Cell>: HasCells, HasFallBack, HasHeader, HasCount
where Header: UITableViewHeaderFooterView,
      Header: HasViewModel,
      Header.ViewModel: HasFallBack,
      Cell: UITableViewCell,
      Cell: HasViewModel {

    public static var fallBack: Self { .init() }

    public typealias Head = Header

    public var headerViewModel: Header.ViewModel = .fallBack
    public var cellsViewModels: [Cell.ViewModel] = []
    public var cellTapped: CellTapAction?

    public init() {
        self.headerViewModel = .fallBack
        self.cellsViewModels = []
        self.cellTapped = nil
    }

    public init(
        headerViewModel: Header.ViewModel = .fallBack,
        cellsViewModels: [Cell.ViewModel] = [],
        cellTapped: CellTapAction? = nil
    ) {
        self.headerViewModel = headerViewModel
        self.cellsViewModels = cellsViewModels
        self.cellTapped = cellTapped
    }
}

public class TextView: UIView, HasViewModel {

    public struct ViewModel: HasInit {
        var string: String = "cats"
        public init() {
            self.string = "cats"
        }
        public static var fallBack: Self { .init(string: "cats") }
        public init(string: String) {
            self.string = string
        }
    }

    public var viewModel: ViewModel = .fallBack
}
