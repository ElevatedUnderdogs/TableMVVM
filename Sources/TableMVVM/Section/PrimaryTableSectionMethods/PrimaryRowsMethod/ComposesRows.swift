//
//  ComposesRows.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/12/21.
//

import UIKit

/// Inherited by `SectionWithRowsHeader`, `SectionWithHeader`, `SectionWithoutHeader`
 protocol ComposesRows: PrimaryRowsMethods {
    associatedtype Rows: PrimaryRowsMethods
    var rows: Rows { get }
}

 extension ComposesRows {

    var count: Int {
        rows.count
    }

    func tableViewNumberOfRows(_ tableView: UITableView) -> Int {
        rows.tableViewNumberOfRows(tableView)
    }

    func tableViewDidSelectRowAt(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rows.tableViewDidSelectRowAt(tableView, didSelectRowAt: indexPath)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        rows.tableView(tableView, cellForRowAt: indexPath)
    }
}

 extension ComposesRows where Rows: RegistersCells {

    func registerCells(tableView: UITableView) {
        rows.registerCells(tableView: tableView)
    }
}
