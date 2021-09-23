//
// TableDataSource.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/11/21.
//

import UIKit

public protocol HasFallBack {
    static var fallBack: Self { get }
}

public protocol HasInit: HasFallBack {
    init()
}

extension HasInit {
    public static var fallBack: Self { .init() }
}

 public protocol HasCount {
    var count: Int { get }
}

extension UIView: HasFallBack {
    public static var fallBack: Self { .init(frame: .zero) }
}

extension UIView: HasInit {}
