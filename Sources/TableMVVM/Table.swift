//
//  Table.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/11/21.
//

import UIKit

 protocol RegistersCells {
    func registerCells(tableView: UITableView)
}

 protocol HasRegistrationCandidates: RegistersCells & RegistersHeader {
    var registerCandidates: [RegistersCells & RegistersHeader] { get }
}

 extension HasRegistrationCandidates {
    func registerCells(tableView: UITableView) {
        for index in registerCandidates.indices {
            registerCandidates[index].registerCells(tableView: tableView)
        }
    }

    func registerHeader(tableView: UITableView) {
        for index in registerCandidates.indices {
            registerCandidates[index].registerHeader(tableView: tableView)
        }
    }
}

 protocol HasTable: AnyObject {
    var table: UITableView? { get set }
}

 extension HasTable {
    func set(table: UITableView) {
        self.table = table
    }
}

 protocol HasViewModel {

    associatedtype ViewModel
    var viewModel: ViewModel { get set }
    init()
}

 extension HasViewModel {
    init(viewModel: ViewModel) {
        self.init()
        self.viewModel = viewModel
    }
}
