//
//  SectionAlternator.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/12/21.
//

import UIKit

 protocol SectionAlternator {
    var currentSection: PrimaryTableSectionMethods & HasCount { get }
}

 extension SectionAlternator {

    func tableViewNumberOfRows(_ tableView: UITableView) -> Int {
        currentSection.tableViewNumberOfRows(tableView)
    }

    func tableViewDidSelectRowAt(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentSection.tableViewDidSelectRowAt(tableView, didSelectRowAt: indexPath)
    }

    func tableViewViewForHeader(_ tableView: UITableView) -> UIView? {
        currentSection.tableViewViewForHeader(tableView)
    }

    func tableViewHeightForHeaderInSection(_ tableView: UITableView) -> CGFloat {
        currentSection.tableViewHeightForHeaderInSection(tableView)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        currentSection.tableView(tableView, cellForRowAt: indexPath)
    }
}
