//
//  Table.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/11/21.
//

import UIKit

public protocol RegistersCells {
    func registerCells(tableView: UITableView)
}

public protocol HasRegistrationCandidates: RegistersCells & RegistersHeader {
    var registerCandidates: [RegistersCells & RegistersHeader] { get }
}

extension HasRegistrationCandidates {
    public func registerCells(tableView: UITableView) {
        for index in registerCandidates.indices {
            registerCandidates[index].registerCells(tableView: tableView)
        }
    }
    
    public func registerHeader(tableView: UITableView) {
        for index in registerCandidates.indices {
            registerCandidates[index].registerHeader(tableView: tableView)
        }
    }
}

public protocol HasTable: AnyObject {
    var table: UITableView? { get set }
}

extension HasTable {
    public func set(table: UITableView) {
        self.table = table
    }
}

public protocol HasViewModel {
    
    associatedtype ViewModel
    var viewModel: ViewModel { get set }
    init()
}

extension HasViewModel {
    public init(viewModel: ViewModel) {
        self.init()
        self.viewModel = viewModel
    }
}
