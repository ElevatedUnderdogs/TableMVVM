//
//  Header.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/12/21.
//

import UIKit

public struct Header<Head: UITableViewHeaderFooterView>: HasHeader, HasInit, RegistersHeader
where Head: HasViewModel,
      Head.ViewModel: HasInit {

    public var headerViewModel: Head.ViewModel = .init()
    public init() { self.headerViewModel = .init() }
    public init(headerViewModel: Head.ViewModel) {
        self.headerViewModel = headerViewModel
    }
}
