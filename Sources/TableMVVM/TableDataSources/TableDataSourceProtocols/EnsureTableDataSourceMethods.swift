//
//  EnsureTableDataSourceMethods.swift
//  
//
//  Created by Scott Lydon on 9/23/21.
//

import UIKit

/// A protocol to make non-optional the UITableDataSource and UITableviewDelegate methods
/// Purpose: So that dataSource alternators do not have to make assumptions about what the expected behavior is
/// when a data source is nil or returns nil.
/// Requiring these functions to be non optional forces the user to answer for what to do for each case.
public protocol EnsureTableDataSourceMethods: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
}
