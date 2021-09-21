//
//  RowsAlternator.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/12/21.
//

import UIKit

/// Inherited by `CanAlternate2Rows` ultimately by: `RowAlternator2`
 protocol AlternatesRows: PrimaryRowsMethods {
    var currentRows: PrimaryRowsMethods { get }
}

 extension AlternatesRows {

    func tableViewNumberOfRows(_ tableView: UITableView) -> Int {
        currentRows.tableViewNumberOfRows(tableView)
    }

    func tableViewDidSelectRowAt(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentRows.tableViewDidSelectRowAt(tableView, didSelectRowAt: indexPath)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        currentRows.tableView(tableView, cellForRowAt: indexPath)
    }

    var count: Int {
        currentRows.count
    }
}
