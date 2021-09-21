//
//  UIView.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/14/21.
//

import UIKit

 extension UIView {

    /// Inserts a subview and constrains it to fill this view (the superview) by default.
    ///  Using string formats supports older OS.  This has an early exit if the
    /// view is already injected.  This also clears the subViews before injecting.
    /// - Parameters:
    ///   - view: The view you are injecting
    public func inject(view: UIView, insets: UIEdgeInsets = .zero) {
        guard !subviews.contains(view) else { return }
        if !subviews.isEmpty {
            subviews.forEach { $0.removeFromSuperview() }
        }
        view.frame = bounds
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        [
            topAnchor.constraint(equalTo: view.topAnchor, constant: -insets.top),
            leftAnchor.constraint(equalTo: view.leftAnchor, constant: -insets.left),
            rightAnchor.constraint(equalTo: view.rightAnchor, constant: insets.right),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: insets.bottom)
        ].forEach {
            $0.isActive = true
        }
    }
}
