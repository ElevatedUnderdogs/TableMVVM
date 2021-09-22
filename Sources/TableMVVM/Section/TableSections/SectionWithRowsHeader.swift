//
//  SectionWithRowsHeader.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/12/21.
//

import UIKit

/// ComposedHeader could be:  `SectionWithRowsHeader`, `Section`, `Header`, `SectionNoHeader`, `SectionWithoutHeader`
/// ComposedRows:  `OneRow`, `Rows`
 public struct SectionWithRowsHeader<
    ComposedHeader,
    ComposedRows
>: ComposesRows, HasFallBack, ComposesHeader, RegistersCells, RegistersHeader
where ComposedHeader: PrimaryHeaderMethods,
      ComposedHeader: HasFallBack,
      ComposedHeader: RegistersHeader,
      ComposedRows: PrimaryRowsMethods,
      ComposedRows: HasFallBack,
      ComposedRows: RegistersCells {
    
    public static var fallBack: Self { .init() }
    public var header: ComposedHeader = .fallBack
    public var rows: ComposedRows = .fallBack
    public init(header: ComposedHeader = .fallBack, rows: ComposedRows = .fallBack) {
        self.header = header
        self.rows = rows
    }
}
