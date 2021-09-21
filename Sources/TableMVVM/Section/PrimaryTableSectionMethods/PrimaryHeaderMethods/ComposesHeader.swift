//
//  ComposesHeader.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/12/21.
//

import UIKit

/// Could be used for alternating headers as the protocol.
/// inherited by: `SectionWithRowsHeader`
 protocol ComposesHeader: PrimaryHeaderMethods {
    associatedtype Header: PrimaryHeaderMethods
    var header: Header { get }
}

 extension ComposesHeader {

    func tableViewViewForHeader(_ tableView: UITableView) -> UIView? {
        header.tableViewViewForHeader(tableView)
    }

    func tableViewHeightForHeaderInSection(_ tableView: UITableView) -> CGFloat {
        header.tableViewHeightForHeaderInSection(tableView)
    }
}

 extension ComposesHeader where Header: RegistersHeader {

    func registerHeader(tableView: UITableView) {
        header.registerHeader(tableView: tableView)
    }
}
