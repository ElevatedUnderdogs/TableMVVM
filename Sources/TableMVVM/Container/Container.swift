//
//  Container.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/16/21.
//

import UIKit


public class Container<Contained: UIView>: UIView, HasViewModel
where Contained: HasViewModel,
      Contained.ViewModel: HasInit {

    var view: Contained = .init(frame: .zero)

    public var viewModel: ViewModel = .init() {
        didSet {
            inject(view: view, insets: viewModel.insets)
            view.viewModel = viewModel.viewModel
        }
    }

    public struct ViewModel: HasFallBack {
        public var insets: UIEdgeInsets = .zero
        public var viewModel: Contained.ViewModel = .fallBack
        public init(insets: UIEdgeInsets = .zero, viewModel: Contained.ViewModel = .fallBack) {
            self.insets = insets
            self.viewModel = viewModel
        }
        public static var fallBack: Self { .init(insets: .zero, viewModel: .fallBack) }
    }
}
