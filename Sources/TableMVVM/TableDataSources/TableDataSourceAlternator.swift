//
//  TableDataSourceAlternator.swift
//  
//
//  Created by Scott Lydon on 9/23/21.
//

import UIKit

public class DataSourceAlternator<
    DataSource1: TableDataSourceAndDelegate,
    DataSource2: TableDataSourceAndDelegate
>: TableDataSourceAndDelegate where
    DataSource1: HasFallBack,
    DataSource2: HasFallBack {

    public var registerCandidates: [RegistersCells & RegistersHeader] { [dataSource1, dataSource2] }

    public var table: UITableView? {
        didSet {
            dataSource1.table = table
            dataSource2.table = table
        }
    }

    public static var fallBack: Self { .init() }

    public var dataSource1: DataSource1 = .fallBack
    public var dataSource2: DataSource2 = .fallBack

    public typealias AlternatingLogic = (DataSource1, DataSource2) -> TableDataSourceAndDelegate
    public var alternatingLogic: AlternatingLogic?

    public var currentDataSource: TableDataSourceAndDelegate {
        alternatingLogic?(dataSource1, dataSource2) ?? dataSource1
    }

    public required init(
        dataSource1: DataSource1 = .fallBack,
        dataSource2: DataSource2 = .fallBack,
        alternatingLogic: AlternatingLogic? = nil
    ) {
        self.dataSource1 = dataSource1
        self.dataSource2 = dataSource2
        self.alternatingLogic = alternatingLogic
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        currentDataSource.numberOfSections(in: tableView)
    }

    public  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentDataSource.tableView(tableView, didSelectRowAt: indexPath)
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        currentDataSource.tableView(tableView, viewForHeaderInSection: section)
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        currentDataSource.tableView(tableView, heightForHeaderInSection: section)
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currentDataSource.tableView(tableView, numberOfRowsInSection: section)
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        currentDataSource.tableView(tableView, cellForRowAt: indexPath)
    }
}
