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
>: CanAlternate2Rows, PrimaryRowsMethods, HasFallBack, RegistersCells
where Rows1: HasFallBack,
      Rows1: RegistersCells,
      Rows2: HasFallBack,
      Rows2: RegistersCells {

    public static var fallBack: Self { .init() }

    public typealias ReturnRows = PrimaryRowsMethods & HasCount & RegistersCells
    public typealias AlternatingLogic = (Rows1, Rows2) -> ReturnRows

    public var rows1: Rows1 = .fallBack
    public var rows2: Rows2 = .fallBack
    public var alternatingLogic: AlternatingLogic?

    public init(
        rows1: Rows1 = .fallBack,
        rows2: Rows2 = .fallBack,
        alternatingLogic: AlternatingLogic? = nil
    ) {
        self.rows1 = rows1
        self.rows2 = rows2
        self.alternatingLogic = alternatingLogic
    }
}

extension RowAlternator2 where Rows1: HasIsEmpty {

    public init(
        rows1: Rows1 = .fallBack,
        rows2: Rows2 = .fallBack
    ) {
        self.rows1 = rows1
        self.rows2 = rows2
        self.alternatingLogic = { rows1, rows2 in
            if rows1.isEmpty {
                return rows2
            } else {
                return rows1
            }
        }
    }
}
