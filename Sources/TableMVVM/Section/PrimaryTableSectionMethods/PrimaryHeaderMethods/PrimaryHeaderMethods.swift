//
//  PrimaryHeaderMethods.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/12/21.
//

import UIKit

/// structs:  `SectionWithRowsHeader`, `Section`, `Header`, `SectionNoHeader`, `SectionWithoutHeader`
/// 
/// Inherited by:  `HasNoHeader`, `HasHeader`, `ComposesHeader`
///   Which are inherited by: `SectionNoHeader`, `SectionWithoutHeader` for `HasNoHeader`
///     inherited by: `SectionNoHeader`, `SectionWithoutHeader`
///   Which are inherited by: `Section`, `Header`, for `HasHeader`
///   Which are inherited by: `SectionWithRowsHeader` for `ComposesHeader`
 protocol PrimaryHeaderMethods {
    func tableViewViewForHeader(_ tableView: UITableView) -> UIView?
    func tableViewHeightForHeaderInSection(_ tableView: UITableView) -> CGFloat
}
