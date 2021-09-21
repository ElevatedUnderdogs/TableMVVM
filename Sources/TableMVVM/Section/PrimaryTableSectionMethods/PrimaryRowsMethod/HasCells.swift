//
//  HasCells.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/12/21.
//

import UIKit

/// Inherited by: `Section`, `SectionNoHeader`
 public protocol HasCells: PrimaryRowsMethods, RegistersCells {
    associatedtype Cell: UITableViewCell, HasViewModel
    typealias CellTapAction = (Cell.ViewModel, IndexPath) -> Void
    var cellsViewModels: [Cell.ViewModel] { get }
    var cellTapped: CellTapAction? { get }
}

 extension HasCells {

    public var count: Int {
        cellsViewModels.count
    }

    public func tableViewNumberOfRows(_ tableView: UITableView) -> Int {
        cellsViewModels.count
    }

    public func registerCells(tableView: UITableView) {
        tableView.register(Cell.self, forCellReuseIdentifier: Cell.className)
    }

    public func tableViewDidSelectRowAt(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellTapped?(cellsViewModels[indexPath.row], indexPath)
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueCell(
            for: indexPath,
            cell: Cell(),
            viewModel: cellsViewModels[indexPath.row]
        )
    }
}
