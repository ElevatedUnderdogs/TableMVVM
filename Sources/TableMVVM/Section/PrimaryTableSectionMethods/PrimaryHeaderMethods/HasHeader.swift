//
//  HasHeader.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/12/21.
//

import UIKit

/// inherited by: `Section`, `Header`
public protocol HasHeader: PrimaryHeaderMethods, RegistersHeader {
    associatedtype Head: UITableViewHeaderFooterView, HasViewModel
    var headerViewModel: Head.ViewModel { get }
}

extension HasHeader {
    
    /// Need to call register view for header first.
    /// **Troubleshooting note**: If this returns nil, are you passing the same
    /// tableview as the one you registered the HeaderFooterOn?
    /// - Parameter tableView: Table view to check if there is a Header available for reuse.
    /// - Returns: returns the header view 
    public func tableViewViewForHeader(_ tableView: UITableView) -> UIView? {
        tableView.dequeueReusableHeaderFooterView(
            section: Head(),
            viewModel: headerViewModel
        )
    }
    
    public func tableViewHeightForHeaderInSection(_ tableView: UITableView) -> CGFloat {
        UITableView.automaticDimension
    }
    
    public func registerHeader(tableView: UITableView) {
        tableView.register(Head.self, forHeaderFooterViewReuseIdentifier: Head.className)
    }
}
