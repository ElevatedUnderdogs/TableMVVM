//
//  Header.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/12/21.
//

import UIKit

 struct Header<Head: UITableViewHeaderFooterView>: HasHeader, HasInit, RegistersHeader
where Head: HasViewModel,
      Head.ViewModel: HasInit {

     var headerViewModel: Head.ViewModel = .init()
}
