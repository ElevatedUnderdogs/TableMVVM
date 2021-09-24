//
//  TableDataSource1.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/11/21.
//

import UIKit

public class TableDataSource1<Section0: PrimaryTableSectionMethods>: TableDataSourceAndDelegate, HasFallBack
where Section0: HasFallBack {

    public static var fallBack: Self { .init() }

    public var table: UITableView?
    public var registerCandidates: [RegistersCells & RegistersHeader] { [section0]
    }

    /// Designated Primary initializer
    /// - Parameter section0: pass an instance of the generic section.
    public required init(section0: Section0 = .fallBack) {
        self.section0 = section0
    }

    public var queue: DispatchQueueType = DispatchQueue.main

    public var section0: Section0 = .fallBack {
        didSet { self.table?.reload(on: queue) }
    }

    public func numberOfSections(in tableView: UITableView) -> Int { 1 }

    public  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 0 else { return }
        return section0.tableViewDidSelectRowAt(tableView, didSelectRowAt: indexPath)
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        section == 0 ? section0.tableViewViewForHeader(tableView) : nil
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        section == 0 ? section0.tableViewHeightForHeaderInSection(tableView) : 0
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // first section count is 0
        section == 0 ? section0.tableViewNumberOfRows(tableView) : 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        indexPath.section == 0 ? section0.tableView(tableView, cellForRowAt: indexPath) :
            UITableViewCell()
    }
}
