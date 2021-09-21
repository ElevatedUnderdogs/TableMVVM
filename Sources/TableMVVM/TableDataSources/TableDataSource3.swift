//
//  TableDataSource3.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/11/21.
//

import UIKit

 class TableDataSource3<
    Section0: PrimaryTableSectionMethods,
    Section1: PrimaryTableSectionMethods,
    Section2: PrimaryTableSectionMethods
>: NSObject, UITableViewDataSource, UITableViewDelegate, HasRegistrationCandidates, HasTable
where Section0: HasInit,
      Section1: HasInit,
      Section2: HasInit {

     var table: UITableView?

    init(
        section0: Section0,
        section1: Section1,
        section2: Section2
    ) {
        self.section0 = section0
        self.section1 = section1
        self.section2 = section2
    }
     var registerCandidates: [RegistersCells & RegistersHeader] { [section0, section1, section2] }

    var queue: DispatchQueueType = DispatchQueue.main

    var section0: Section0 = .init() {
        didSet { self.table?.reload(on: queue) }
    }

    var section1: Section1 = .init() {
        didSet { self.table?.reload(on: queue) }
    }

    var section2: Section2 = .init() {
        didSet { self.table?.reload(on: queue) }
    }

     func numberOfSections(in tableView: UITableView) -> Int { 3 }

     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0: return section0.tableViewDidSelectRowAt(tableView, didSelectRowAt: indexPath)
        case 1: return section1.tableViewDidSelectRowAt(tableView, didSelectRowAt: indexPath)
        case 2: return section2.tableViewDidSelectRowAt(tableView, didSelectRowAt: indexPath)
        default: do {}
        }
    }

     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0: return section0.tableViewViewForHeader(tableView)
        case 1: return section1.tableViewViewForHeader(tableView)
        case 2: return section2.tableViewViewForHeader(tableView)
        default: return nil
        }
    }

     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0: return section0.tableViewHeightForHeaderInSection(tableView)
        case 1: return section1.tableViewHeightForHeaderInSection(tableView)
        case 2: return section2.tableViewHeightForHeaderInSection(tableView)
        default: return 0
        }
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return section0.tableViewNumberOfRows(tableView)
        case 1: return section1.tableViewNumberOfRows(tableView)
        case 2: return section2.tableViewNumberOfRows(tableView)
        default: return 0
        }
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0: return section0.tableView(tableView, cellForRowAt: indexPath)
        case 1: return section1.tableView(tableView, cellForRowAt: indexPath)
        case 2: return section2.tableView(tableView, cellForRowAt: indexPath)
        default: return .init()
        }
    }
}
