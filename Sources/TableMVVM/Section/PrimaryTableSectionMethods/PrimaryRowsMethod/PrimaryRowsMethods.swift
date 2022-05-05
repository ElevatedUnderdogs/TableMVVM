//
//  PrimaryRowsMethods.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/12/21.
//

import UIKit

/// Inherited by: `AlternatesRows`, `HasCells`,  `OneRow`, `Rows`
public protocol PrimaryRowsMethods: HasCount {
    func tableViewNumberOfRows(_ tableView: UITableView) -> Int
    func tableViewDidSelectRowAt(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    var count: Int { get }
}
