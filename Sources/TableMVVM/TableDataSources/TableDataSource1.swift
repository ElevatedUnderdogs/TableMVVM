//
//  TableDataSource1.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/11/21.
//

import UIKit

 class TableDataSource1<
    Section0: PrimaryTableSectionMethods
>: NSObject, UITableViewDataSource, UITableViewDelegate, HasRegistrationCandidates, HasTable
where Section0: HasInit {

     var table: UITableView?
     var registerCandidates: [RegistersCells & RegistersHeader] { [section0] }

    /// Designated Primary initializer
    /// - Parameter section0: pass an instance of the generic section.
    init(section0: Section0) {
        self.section0 = section0
    }

    var queue: DispatchQueueType = DispatchQueue.main

    var section0: Section0 = .init() {
        didSet { self.table?.reload(on: queue) }
    }

     func numberOfSections(in tableView: UITableView) -> Int { 1 }

     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 0 else { return }
        return section0.tableViewDidSelectRowAt(tableView, didSelectRowAt: indexPath)
    }

     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        section == 0 ? section0.tableViewViewForHeader(tableView) : nil
    }

     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        section == 0 ? section0.tableViewHeightForHeaderInSection(tableView) : 0
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // first section count is 0
        section == 0 ? section0.tableViewNumberOfRows(tableView) : 0
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        indexPath.section == 0 ? section0.tableView(tableView, cellForRowAt: indexPath) :
            UITableViewCell()
    }
}
