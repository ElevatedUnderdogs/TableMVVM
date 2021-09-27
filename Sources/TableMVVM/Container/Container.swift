//
//  Container.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/16/21.
//

import UIKit

public class Container<Contained: UIView>: UIView, HasViewModel
where Contained: HasViewModel,
      Contained.ViewModel: HasFallBack {

    var view: Contained = .init(frame: .zero)

    public var viewModel: ViewModel = .init() {
        didSet {
            inject(view: view, insets: viewModel.insets)
            view.viewModel = viewModel.viewModel
            backgroundColor = .clear
        }
    }
}
