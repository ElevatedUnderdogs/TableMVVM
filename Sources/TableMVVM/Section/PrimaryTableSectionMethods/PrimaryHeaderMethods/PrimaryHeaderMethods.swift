//
//  PrimaryHeaderMethods.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/12/21.
//

import UIKit

/// public structs:  `SectionWithRowsHeader`, `Section`, `Header`, `SectionNoHeader`, `SectionWithoutHeader`
/// 
/// Inherited by:  `HasNoHeader`, `HasHeader`, `ComposesHeader`
///   Which are inherited by: `SectionNoHeader`, `SectionWithoutHeader` for `HasNoHeader`
///     inherited by: `SectionNoHeader`, `SectionWithoutHeader`
///   Which are inherited by: `Section`, `Header`, for `HasHeader`
///   Which are inherited by: `SectionWithRowsHeader` for `ComposesHeader`
public protocol PrimaryHeaderMethods {
    func tableViewViewForHeader(_ tableView: UITableView) -> UIView?
    func tableViewHeightForHeaderInSection(_ tableView: UITableView) -> CGFloat
}
