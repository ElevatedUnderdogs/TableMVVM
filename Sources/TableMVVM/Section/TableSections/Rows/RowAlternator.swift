//
//  RowAlternator.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/18/21.
//

import UIKit

/// `PrimaryRowsMethods` inherited  by: `AlternatesRows`, `HasCells`,  `OneRow`, `Rows`
 struct RowAlternator2<
    Rows1: PrimaryRowsMethods,
    Rows2: PrimaryRowsMethods
>: CanAlternate2Rows, PrimaryRowsMethods, HasInit, RegistersCells
where Rows1: HasInit,
      Rows1: RegistersCells,
      Rows2: HasInit,
      Rows2: RegistersCells {

    typealias ReturnRows = PrimaryRowsMethods & HasCount & RegistersCells
    typealias AlternatingLogic = (Rows1, Rows2) -> ReturnRows

         var rows1: Rows1 = .init()
         var rows2: Rows2 = .init()
         var alternatingLogic: AlternatingLogic?
}
