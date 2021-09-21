//
//  OneRow.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/12/21.
//

import UIKit

 struct OneRow<Cell: UITableViewCell>: PrimaryRowsMethods, HasInit, RegistersCells
where Cell: HasViewModel,
      Cell.ViewModel: HasInit {

     var count: Int { 1 }

    var item: Cell.ViewModel = .init()

    var tapped: CellTapAction?

    typealias CellTapAction = (Cell.ViewModel, IndexPath) -> Void

     func registerCells(tableView: UITableView) {
        tableView.register(Cell.self, forCellReuseIdentifier: Cell.className)
    }

     func tableViewNumberOfRows(_ tableView: UITableView) -> Int { 1 }

     func tableViewDidSelectRowAt(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexPath.row == 0 ? tapped?(item, indexPath) : assertionFailure()
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueCell(
            for: indexPath,
            cell: Cell(),
            viewModel: item
        )
    }
}
