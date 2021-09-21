//
//  UITableView.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/11/21.
//

import UIKit

 extension UITableView {

    /// Convenience function for reloading data on the main thread.
    /// - Parameter queue: defualt is main.
    public func reload(on queue: DispatchQueueType = DispatchQueue.main) {
        queue.async { self.reloadData() }
    }

    /// dequeues a UITableViewHeaderFooterView of the type matching the
    /// UITableViewHeaderFooterView argument's type, and assigns a view model to that
    /// UITableViewHeaderFooterView.
    ///
    /// - Parameters:
    ///   - indexPath: indexpath of the cell
    ///   - cell: An argument only provided for the purpose to assist Swift's generic type inference.
    ///   - viewModel: The view model to be assigned to the cell.
    /// - Returns: returns a `UITableViewHeaderFooterView`
    public func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(
        section: T, viewModel: T.ViewModel?) -> UITableViewHeaderFooterView
    where T: HasViewModel {
        guard var cell: T = dequeueReusableHeaderFooterView(withIdentifier: T.className) as? T,
              let viewModel = viewModel else { return .init() }
        cell.viewModel = viewModel
        return cell
    }

    /// dequeues a cell of the type matching the cell argument's type, and assigns a view model to that cell.
    /// - Parameters:
    ///   - indexPath: indexpath of the cell
    ///   - cell: An argument only provided for the purpose to assist Swift's generic type inference.
    ///   - viewModel: The view model to be assigned to the cell.
    /// - Returns: returns a `UITableViewCell`
    public func dequeueCell<T: UITableViewCell>(
        for indexPath: IndexPath, cell: T, viewModel: T.ViewModel?) -> UITableViewCell
    where T: HasViewModel {
        guard var cell = dequeueReusableCell(withIdentifier: T.className, for: indexPath) as? T,
              let viewModel = viewModel else { return .init() }
        cell.viewModel = viewModel
        return cell
    }
}
