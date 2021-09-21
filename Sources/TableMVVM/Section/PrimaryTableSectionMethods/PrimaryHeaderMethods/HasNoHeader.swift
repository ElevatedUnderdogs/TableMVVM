//
//  NoHeader.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/12/21.
//

import UIKit

/// inherited by: `SectionNoHeader`, `SectionWithoutHeader` 
 protocol HasNoHeader: PrimaryHeaderMethods, RegistersHeader {}

 extension HasNoHeader {
    func tableViewViewForHeader(_ tableView: UITableView) -> UIView? { nil }
    func tableViewHeightForHeaderInSection(_ tableView: UITableView) -> CGFloat { 0 }
    func registerHeader(tableView: UITableView) { /*provided to explicitly not register*/ }
}
