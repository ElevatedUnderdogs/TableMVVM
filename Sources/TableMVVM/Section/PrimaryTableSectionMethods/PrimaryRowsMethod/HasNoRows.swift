//
//  HasNoRows.swift
//  
//
//  Created by Scott Lydon on 9/23/21.
//

import UIKit

/// inherited by: `SectionNoHeader`, `SectionWithoutHeader`
public protocol HasNoRows: PrimaryRowsMethods, RegistersCells {}

extension HasNoRows {
    /// Inherited by: `AlternatesRows`, `HasCells`,  `OneRow`, `Rows`
    public func tableViewNumberOfRows(_ tableView: UITableView) -> Int { 0 }
    public func tableViewDidSelectRowAt(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        do {}
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { .init() }
    public var count: Int { 0 }
    public func registerCells(tableView: UITableView) {/*provided to explicitly not register cells*/}
}

