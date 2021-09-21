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
>: ComposesRows, HasInit, ComposesHeader, RegistersCells, RegistersHeader
where ComposedHeader: PrimaryHeaderMethods,
      ComposedHeader: HasInit,
      ComposedHeader: RegistersHeader,
      ComposedRows: PrimaryRowsMethods,
      ComposedRows: HasInit,
      ComposedRows: RegistersCells {

    public var header: ComposedHeader = .init()
    public var rows: ComposedRows = .init()
}
