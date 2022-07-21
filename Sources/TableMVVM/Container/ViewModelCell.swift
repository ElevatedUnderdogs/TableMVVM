//
//  ViewModelCell.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/16/21.
//

import UIKit

/// Purpose: Sometimes developers may be tempted to design a view integrated with a `UITableViewCell`
/// This becomes problematic when you need to use that view separately.  So then you either duplicate the code
/// or have to refactor out the view from the cell so that it can be used separately from a `UITableViewCell`
/// and as a subview to a `UItableviewCell`.
///
/// ViewModelCell automatically lets you inject a view into a TableViewCell
public class ViewModelCell<View: UIView>: UITableViewCell, HasViewModel
where View: HasViewModel,
      View.ViewModel: HasFallBack {
    
    var view: View = .init(frame: .zero)
    
    /// This is used as a reuse identifier when dequeueing the cell.
    override public class var className: String {
        View.className
    }
    
    override public func addSubview(_ view: UIView) {
        super.addSubview(view)
        clearContainer()
    }
    
    @available(iOS 14.0, *)
    public override func setNeedsUpdateConfiguration() {
        clearContainer()
    }
    
    @available(iOS 14.0, *)
    public override func updateConfiguration(using state: UICellConfigurationState) {
        super.updateConfiguration(using: state)
        clearContainer()
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        clearContainer()
    }
    
    public override func didMoveToWindow() {
        super.didMoveToWindow()
        clearContainer()
    }
    
    func clearContainer() {
        contentView.backgroundColor = .clear
        tintColor = .clear
        contentView.backgroundColor = .clear
        subviews.first?.backgroundColor = .clear
        subviews.first?.subviews.first?.backgroundColor = .clear
        subviews.first?.allSubViews.forEach { $0.backgroundColor = .clear }
    }
    
    public typealias ViewModel = View.ViewModel
    
    public var viewModel: ViewModel = .fallBack {
        didSet {
            clearContainer()
            selectionStyle = .none
            contentView.inject(view: view)
            view.viewModel = viewModel
        }
    }
}
