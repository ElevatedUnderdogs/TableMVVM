//
//  TableMVVM.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/14/21.
//

import UIKit

/// Example:
/// `typealias MyDataSource = TableDataSource1<SectionNoHeader<ColorCell>>`
/// `TableMVVM<MyDataSource>`
public class UITableMVVM<ViewModel>: UITableView
where ViewModel: UITableViewDataSource,
      ViewModel: UITableViewDelegate,
      ViewModel: RegistersCells,
      ViewModel: RegistersHeader,
      ViewModel: HasTable {

    public convenience init(
        viewModel: ViewModel,
        presentationLogic: ((ViewModel?) -> ViewModel)? = nil
    ) {
        self.init(frame: .zero)
        self.viewModel = viewModel
        self.viewModel?.table = self
        self.presentationLogic = presentationLogic
        self.presentationViewModel = presentationLogic?(viewModel) ?? viewModel
        assert(presentationViewModel != nil)
        presentationViewModel?.registerCells(tableView: self)
        presentationViewModel?.registerHeader(tableView: self)
        delegate = presentationViewModel
        dataSource = presentationViewModel
        assert(delegate != nil)
        assert(dataSource != nil)
        DispatchQueue.main.async {
            self.reloadData()
            self.separatorColor = .clear
            self.tableFooterView = UIView()
        }
    }

    public typealias ViewModel = ViewModel
    public typealias Action = () -> Void

    var presentationLogic: ((ViewModel?) -> ViewModel)?

    public func updateViewModelWithoutTableUpdate(_ action: Action) {
        updatesEnabled = false
        action()
        updatesEnabled = true
    }

    private var updatesEnabled: Bool = true

    public var viewModel: ViewModel? {
        didSet {
            guard updatesEnabled else { return }
            self.presentationViewModel = presentationLogic?(viewModel) ?? viewModel
        }
    }

    private(set) var presentationViewModel: ViewModel? {
        didSet {
            delegate = presentationViewModel
            dataSource = presentationViewModel
            presentationViewModel?.registerCells(tableView: self)
            presentationViewModel?.registerHeader(tableView: self)
            DispatchQueue.main.async {
                self.reloadData()
                self.separatorColor = .clear
                self.tableFooterView = UIView()
            }
        }
    }

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }

    required init?(coder: NSCoder) {
        nil
    }
}
