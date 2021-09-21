//
//  TableDataSource2.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/11/21.
//

import UIKit

 class TableDataSource2<
    Section0: PrimaryTableSectionMethods,
    Section1: PrimaryTableSectionMethods
>: NSObject, UITableViewDataSource, UITableViewDelegate, HasRegistrationCandidates, HasTable
where Section0: HasInit,
      Section1: HasInit {

     var table: UITableView?

    init(
        section0: Section0,
        section1: Section1
    ) {
        self.section0 = section0
        self.section1 = section1
    }
    var queue: DispatchQueueType = DispatchQueue.main

     var registerCandidates: [RegistersCells & RegistersHeader] { [section0, section1] }

    var section0: Section0 = .init() {
        didSet { self.table?.reload(on: queue) }
    }

    var section1: Section1 = .init() {
        didSet { self.table?.reload(on: queue) }
    }

     func numberOfSections(in tableView: UITableView) -> Int { 2 }

     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0: return section0.tableViewDidSelectRowAt(tableView, didSelectRowAt: indexPath)
        case 1: return section1.tableViewDidSelectRowAt(tableView, didSelectRowAt: indexPath)
        default: do {}
        }
    }

     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0: return section0.tableViewViewForHeader(tableView)
        case 1: return section1.tableViewViewForHeader(tableView)
        default: return nil
        }
    }

     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0: return section0.tableViewHeightForHeaderInSection(tableView)
        case 1: return section1.tableViewHeightForHeaderInSection(tableView)
        default: return 0
        }
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return section0.tableViewNumberOfRows(tableView)
        case 1: return section1.tableViewNumberOfRows(tableView)
        default: return 0
        }
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0: return section0.tableView(tableView, cellForRowAt: indexPath)
        case 1: return section1.tableView(tableView, cellForRowAt: indexPath)
        default: return .init()
        }
    }
}
