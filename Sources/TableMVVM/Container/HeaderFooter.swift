//
//  HeaderFooterView.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/16/21.
//

import UIKit


/// Purpose: Sometimes developers may be tempted to design a view integrated with a `UITableViewHeaderFooterView`
/// This becomes problematic when you need to use that view separately.  So then you either duplicate the code
/// or have to refactor out the view from the cell so that it can be used separately from a `UITableViewCell` and
/// as a subview to a `UItableviewCell`.
 public class HeaderFooter<View: UIView>: UITableViewHeaderFooterView, HasViewModel
where View: HasViewModel,
      View.ViewModel: HasInit {

    var view: View = .init(frame: .zero)

    /// This is used as a reuse identifier when dequeueing the cell.
     override public class var className: String {
        View.className
    }

     public typealias ViewModel = View.ViewModel

    public var viewModel: ViewModel = .fallBack {
        didSet {
            // Makes clear the stupid default background for UITableViewHeaderFooterView:
            // UISystemBackgroundView.
            contentView.inject(view: view)
            subviews.first?.backgroundColor = .clear
            subviews.first?.subviews.first?.backgroundColor = .clear
            view.viewModel = viewModel
        }
    }
}
