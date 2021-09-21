//
//  RowsAlternator.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/12/21.
//

import UIKit

/// Inherited by `CanAlternate2Rows` ultimately by: `RowAlternator2`
 public protocol AlternatesRows: PrimaryRowsMethods {
    var currentRows: PrimaryRowsMethods { get }
}

 extension AlternatesRows {

    public func tableViewNumberOfRows(_ tableView: UITableView) -> Int {
        currentRows.tableViewNumberOfRows(tableView)
    }

    public func tableViewDidSelectRowAt(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentRows.tableViewDidSelectRowAt(tableView, didSelectRowAt: indexPath)
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        currentRows.tableView(tableView, cellForRowAt: indexPath)
    }

    public var count: Int {
        currentRows.count
    }
}
