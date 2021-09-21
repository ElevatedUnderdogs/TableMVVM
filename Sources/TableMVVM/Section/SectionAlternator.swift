//
//  SectionAlternator.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/12/21.
//

import UIKit

 public protocol SectionAlternator {
    var currentSection: PrimaryTableSectionMethods & HasCount { get }
}

 extension SectionAlternator {

    public func tableViewNumberOfRows(_ tableView: UITableView) -> Int {
        currentSection.tableViewNumberOfRows(tableView)
    }

    public func tableViewDidSelectRowAt(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentSection.tableViewDidSelectRowAt(tableView, didSelectRowAt: indexPath)
    }

    public func tableViewViewForHeader(_ tableView: UITableView) -> UIView? {
        currentSection.tableViewViewForHeader(tableView)
    }

    public func tableViewHeightForHeaderInSection(_ tableView: UITableView) -> CGFloat {
        currentSection.tableViewHeightForHeaderInSection(tableView)
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        currentSection.tableView(tableView, cellForRowAt: indexPath)
    }
}
