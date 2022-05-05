//
//  OneRow.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/12/21.
//

import UIKit

public struct OneRow<Cell: UITableViewCell>: PrimaryRowsMethods, HasFallBack, RegistersCells, HasViewModel
where Cell: HasViewModel,
      Cell.ViewModel: HasFallBack {

    public init() {
        self.item = .fallBack
        self.tapped = nil
    }

    public static var fallBack: Self { .init() }

    public var count: Int { 1 }

    public var item: Cell.ViewModel {
        set {
            viewModel = newValue
        }
        get {
            viewModel
        }
    }

    public var viewModel: Cell.ViewModel = .fallBack

    public var tapped: CellTapAction?

    /// Initializes a OneRow
    /// - Parameters:
    ///   - item: The item is the same as viewModel
    ///   - tapped: action when the cell is tapped.
    public init(item: Cell.ViewModel = .fallBack, tapped: CellTapAction? = nil) {
        self.item = item
        self.tapped = tapped
    }

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
