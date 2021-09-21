//
//  RowAlternator.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/18/21.
//

import UIKit

/// `PrimaryRowsMethods` inherited  by: `AlternatesRows`, `HasCells`,  `OneRow`, `Rows`
 public struct RowAlternator2<
    Rows1: PrimaryRowsMethods,
    Rows2: PrimaryRowsMethods
>: CanAlternate2Rows, PrimaryRowsMethods, HasInit, RegistersCells
where Rows1: HasInit,
      Rows1: RegistersCells,
      Rows2: HasInit,
      Rows2: RegistersCells {

    public typealias ReturnRows = PrimaryRowsMethods & HasCount & RegistersCells
    public typealias AlternatingLogic = (Rows1, Rows2) -> ReturnRows

         public var rows1: Rows1 = .init()
         public var rows2: Rows2 = .init()
         public var alternatingLogic: AlternatingLogic?


}
