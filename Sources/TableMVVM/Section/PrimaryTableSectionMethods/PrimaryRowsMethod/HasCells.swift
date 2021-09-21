//
//  HasCells.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/12/21.
//

import UIKit

/// Inherited by: `Section`, `SectionNoHeader`
 protocol HasCells: PrimaryRowsMethods, RegistersCells {
    associatedtype Cell: UITableViewCell, HasViewModel
    typealias CellTapAction = (Cell.ViewModel, IndexPath) -> Void
    var cellsViewModels: [Cell.ViewModel] { get }
    var cellTapped: CellTapAction? { get }
}

 extension HasCells {

    var count: Int {
        cellsViewModels.count
    }

    func tableViewNumberOfRows(_ tableView: UITableView) -> Int {
        cellsViewModels.count
    }

    func registerCells(tableView: UITableView) {
        tableView.register(Cell.self, forCellReuseIdentifier: Cell.className)
    }

    func tableViewDidSelectRowAt(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellTapped?(cellsViewModels[indexPath.row], indexPath)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueCell(
            for: indexPath,
            cell: Cell(),
            viewModel: cellsViewModels[indexPath.row]
        )
    }
}
