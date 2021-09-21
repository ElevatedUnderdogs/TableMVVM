//
//  ComposesRows.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/12/21.
//

import UIKit

/// Inherited by `SectionWithRowsHeader`, `SectionWithHeader`, `SectionWithoutHeader`
 public protocol ComposesRows: PrimaryRowsMethods {
    associatedtype Rows: PrimaryRowsMethods
    var rows: Rows { get }
}

 extension ComposesRows {

    public var count: Int {
        rows.count
    }

    public func tableViewNumberOfRows(_ tableView: UITableView) -> Int {
        rows.tableViewNumberOfRows(tableView)
    }

    public func tableViewDidSelectRowAt(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rows.tableViewDidSelectRowAt(tableView, didSelectRowAt: indexPath)
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        rows.tableView(tableView, cellForRowAt: indexPath)
    }
}

 extension ComposesRows where Rows: RegistersCells {

    public func registerCells(tableView: UITableView) {
        rows.registerCells(tableView: tableView)
    }
}
