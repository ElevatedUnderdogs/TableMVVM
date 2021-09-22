//
//  SectionWithoutHeader.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/12/21.
//

import UIKit

/// ComposedRows can be `AlternatesRows`, `HasCells`,  `OneRow`, `Rows`
public struct SectionWithoutHeader<ComposedRows>: ComposesRows, HasFallBack, HasNoHeader, RegistersCells
where ComposedRows: PrimaryRowsMethods,
      ComposedRows: HasFallBack,
      ComposedRows: RegistersCells {

    public static var fallBack: Self { .init() }
    public  var rows: ComposedRows = .fallBack
}
