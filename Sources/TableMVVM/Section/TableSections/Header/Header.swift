//
//  Header.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/12/21.
//

import UIKit

/// A struct space for HeaderFooterView type information along with viewModel data for it.
public struct Header<Head: UITableViewHeaderFooterView>: HasHeader, RegistersHeader, HasInit, HasViewModel
where Head: HasViewModel,
      Head.ViewModel: HasFallBack {

    public var viewModel: Head.ViewModel = .fallBack

    public init() {
        self.viewModel = .fallBack
    }
}
