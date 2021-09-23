//
// TableDataSource.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/11/21.
//

import UIKit

/// It would have been ideal to have just `HasInit`
/// Because `HasInit`, plays well with `UIView`s
/// and with synthesized initializers with structs.  The problem
/// is that synthesized struct initializers are internal and
/// don't become public even when the properties are labeled public.
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
