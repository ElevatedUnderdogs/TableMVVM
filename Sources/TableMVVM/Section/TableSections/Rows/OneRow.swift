//
//  OneRow.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/12/21.
//

import UIKit

public struct OneRow<Cell: UITableViewCell>: PrimaryRowsMethods, HasFallBack, RegistersCells
where Cell: HasViewModel,
      Cell.ViewModel: HasFallBack {

    public static var fallBack: Self { .init() }

    public var count: Int { 1 }

    var item: Cell.ViewModel = .fallBack

    var tapped: CellTapAction?

    public typealias CellTapAction = (Cell.ViewModel, IndexPath) -> Void

    public func registerCells(tableView: UITableView) {
        tableView.register(Cell.self, forCellReuseIdentifier: Cell.className)
    }

    public func tableViewNumberOfRows(_ tableView: UITableView) -> Int { 1 }

    public func tableViewDidSelectRowAt(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexPath.row == 0 ? tapped?(item, indexPath) : assertionFailure()
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueCell(
            for: indexPath,
            cell: Cell(),
            viewModel: item
        )
    }
}
