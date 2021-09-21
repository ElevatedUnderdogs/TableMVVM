//
//  Rows.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/12/21.
//

import UIKit

 struct Rows<Cell: UITableViewCell>: PrimaryRowsMethods, HasInit, RegistersCells
where Cell: HasViewModel {

    typealias CellTapAction = (Cell.ViewModel, IndexPath) -> Void

    var items: [Cell.ViewModel] = []
    var tapped: CellTapAction?
     var count: Int { items.count }

     func registerCells(tableView: UITableView) {
        tableView.register(Cell.self, forCellReuseIdentifier: Cell.className)
    }

     func tableViewNumberOfRows(_ tableView: UITableView) -> Int {
        items.count
    }

     func tableViewDidSelectRowAt(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tapped?(items[indexPath.row], indexPath)
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueCell(
            for: indexPath,
            cell: Cell(),
            viewModel: items[indexPath.row]
        )
    }
}
