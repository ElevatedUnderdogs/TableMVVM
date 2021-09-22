//
//  Header.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/12/21.
//

import UIKit

public struct Header<Head: UITableViewHeaderFooterView>: HasHeader, RegistersHeader, HasInit
where Head: HasViewModel,
      Head.ViewModel: HasInit {

    public var headerViewModel: Head.ViewModel = .fallBack
    public init() { self.headerViewModel = .fallBack }
    public init(headerViewModel: Head.ViewModel) {
        self.headerViewModel = headerViewModel
    }
}
