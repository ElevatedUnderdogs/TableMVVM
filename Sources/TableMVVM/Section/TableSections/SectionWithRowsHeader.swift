//
//  SectionWithRowsHeader.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/12/21.
//

import UIKit

/// ComposedHeader could be:  `SectionWithRowsHeader`, `Section`, `Header`, `SectionNoHeader`, `SectionWithoutHeader`
/// ComposedRows:  `OneRow`, `Rows`
 struct SectionWithRowsHeader<
    ComposedHeader,
    ComposedRows
>: ComposesRows, HasInit, ComposesHeader, RegistersCells, RegistersHeader
where ComposedHeader: PrimaryHeaderMethods,
      ComposedHeader: HasInit,
      ComposedHeader: RegistersHeader,
      ComposedRows: PrimaryRowsMethods,
      ComposedRows: HasInit,
      ComposedRows: RegistersCells {

         var header: ComposedHeader = .init()
     var rows: ComposedRows = .init()
}
