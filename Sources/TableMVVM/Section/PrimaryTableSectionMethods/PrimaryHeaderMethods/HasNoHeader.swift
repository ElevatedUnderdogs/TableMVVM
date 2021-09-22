//
//  NoHeader.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/12/21.
//

import UIKit

/// inherited by: `SectionNoHeader`, `SectionWithoutHeader` 
public protocol HasNoHeader: PrimaryHeaderMethods, RegistersHeader {}

extension HasNoHeader {
    public func tableViewViewForHeader(_ tableView: UITableView) -> UIView? { nil }
    public func tableViewHeightForHeaderInSection(_ tableView: UITableView) -> CGFloat { 0 }
    public func registerHeader(tableView: UITableView) { /*provided to explicitly not register*/ }
}
