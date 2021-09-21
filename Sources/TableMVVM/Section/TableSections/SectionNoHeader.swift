//
//  SectionNoHeader.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/11/21.
//

import UIKit

/// Definition:
/// ```
/// struct SectionNoHeader<Cell>: HasCells, HasInit, HasNoHeader`
///    where Cell: UITableViewCell,
///    Cell: HasViewModel
/// ```
 struct SectionNoHeader<Cell>: HasCells, HasInit, HasNoHeader, HasCount
where Cell: UITableViewCell,
      Cell: HasViewModel {

         var cellsViewModels: [Cell.ViewModel] = []
         var cellTapped: CellTapAction?
}
