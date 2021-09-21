//
//  Rows.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/12/21.
//

import UIKit

 public struct Rows<Cell: UITableViewCell>: PrimaryRowsMethods, HasInit, RegistersCells
where Cell: HasViewModel {

    public typealias CellTapAction = (Cell.ViewModel, IndexPath) -> Void

    var items: [Cell.ViewModel] = []
    var tapped: CellTapAction?
    public var count: Int { items.count }

    public func registerCells(tableView: UITableView) {
        tableView.register(Cell.self, forCellReuseIdentifier: Cell.className)
    }

    public func tableViewNumberOfRows(_ tableView: UITableView) -> Int {
        items.count
    }

    public func tableViewDidSelectRowAt(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tapped?(items[indexPath.row], indexPath)
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueCell(
            for: indexPath,
            cell: Cell(),
            viewModel: items[indexPath.row]
        )
    }

}
