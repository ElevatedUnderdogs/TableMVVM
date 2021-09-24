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

extension SectionWithRowsHeader where ComposedHeader: HasViewModel {
    public init(headerModel: ComposedHeader.ViewModel, rows: ComposedRows) {
        self.init(header: ComposedHeader(viewModel: headerModel), rows: rows)
    }
}

extension SectionWithRowsHeader where ComposedRows: HasViewModel {
    public init(header: ComposedHeader, rowModel: ComposedRows.ViewModel) {
        self.init(header: header, rows: ComposedRows(viewModel: rowModel))
    }
}

extension SectionWithRowsHeader where ComposedHeader: HasViewModel, ComposedRows: HasViewModel {
    public init(headerModel: ComposedHeader.ViewModel, rowModel: ComposedRows.ViewModel) {
        self.init(header: ComposedHeader(viewModel: headerModel), rows: ComposedRows(viewModel: rowModel))
    }
}
