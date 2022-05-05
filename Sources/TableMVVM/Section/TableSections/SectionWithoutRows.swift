//
//  SectionWithoutRows.swift
//  
//
//  Created by Scott Lydon on 9/23/21.
//

import UIKit

/// ComposedHeader can be `Header`
public struct SectionWithoutRows<ComposedHeader>:
    ComposesHeader,
    HasFallBack,
    HasNoRows,
    RegistersHeader
where ComposedHeader: PrimaryHeaderMethods,
      ComposedHeader: HasFallBack,
      ComposedHeader: RegistersHeader {

    public static var fallBack: Self { .init() }
    public var header: ComposedHeader = .fallBack
    public init(header: ComposedHeader = .fallBack) {
        self.header = header
    }
}

