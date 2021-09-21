//
//  SectionWithoutHeader.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/12/21.
//

import UIKit

/// ComposedRows can be `AlternatesRows`, `HasCells`,  `OneRow`, `Rows`
 public struct SectionWithoutHeader<ComposedRows>: ComposesRows, HasInit, HasNoHeader, RegistersCells
where ComposedRows: PrimaryRowsMethods,
      ComposedRows: HasInit,
      ComposedRows: RegistersCells {

       public  var rows: ComposedRows = .init()
}
