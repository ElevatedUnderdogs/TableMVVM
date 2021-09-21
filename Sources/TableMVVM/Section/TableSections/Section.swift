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
///     struct Section<Header, Cell>: HasCells, HasInit, HasHeader
///     where Header: UITableViewHeaderFooterView,
///           Header: HasViewModel,
///           Header.ViewModel: HasInit,
///           Cell: UITableViewCell,
///           Cell: HasViewModel {
/// ```
 struct Section<Header, Cell>: HasCells, HasInit, HasHeader, HasCount
where Header: UITableViewHeaderFooterView,
      Header: HasViewModel,
      Header.ViewModel: HasInit,
      Cell: UITableViewCell,
      Cell: HasViewModel {

         typealias Head = Header

         var headerViewModel: Header.ViewModel = .init()
         var cellsViewModels: [Cell.ViewModel] = []
         var cellTapped: CellTapAction?
}

 class TextView: UIView, HasViewModel, HasInit {

     struct ViewModel: HasInit {
        var string: String = "cats"
    }

     var viewModel: ViewModel = .init()
}
