//
//  Container.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/16/21.
//

import UIKit


 class Container<Contained: UIView>: UIView, HasViewModel, HasInit
where Contained: HasViewModel,
      Contained.ViewModel: HasInit {

    var view: Contained = .init(frame: .zero)

     var viewModel: ViewModel = .init() {
        didSet {
            inject(view: view, insets: viewModel.insets)
            view.viewModel = viewModel.viewModel
        }
    }

     struct ViewModel: HasInit {
        var insets: UIEdgeInsets = .zero
        var viewModel: Contained.ViewModel = .init()
    }
}
