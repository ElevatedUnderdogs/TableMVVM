//
//  CanAlternate2Rows.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/18/21.
//

import UIKit

/// Inherited by: `RowAlternator2`
 public protocol CanAlternate2Rows: AlternatesRows, RegistersCells {
    typealias ReturnRows = PrimaryRowsMethods & HasCount & RegistersCells
    associatedtype Rows1: ReturnRows
    associatedtype Rows2: ReturnRows
    var rows1: Rows1 { get set }
    var rows2: Rows2 { get set }
    typealias AlternatingLogic = (Rows1, Rows2) -> ReturnRows
    var alternatingLogic: AlternatingLogic? { get }
}

 extension CanAlternate2Rows {

    public var currentRows: PrimaryRowsMethods {
        alternatingLogic?(rows1, rows2) ?? rows1
    }

    public func registerCells(tableView: UITableView) {
        rows1.registerCells(tableView: tableView)
        rows2.registerCells(tableView: tableView)
    }
}
