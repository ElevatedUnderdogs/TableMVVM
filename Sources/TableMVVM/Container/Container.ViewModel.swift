//
//  File.swift
//  
//
//  Created by Scott Lydon on 9/24/21.
//

import UIKit

extension Container {

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
