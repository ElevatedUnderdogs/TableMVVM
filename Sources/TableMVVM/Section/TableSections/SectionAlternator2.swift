//
//  SectionAlternator2.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/11/21.
//

import UIKit

/// Definition: 
/// ```
/// public struct Alternator2<
/// Section1: PrimaryTableSectionMethods,
/// Section2: PrimaryTableSectionMethods
/// >: PrimaryTableSectionMethods, HasInit, SectionAlternator
/// where Section1: HasInit,
///   Section2: HasInit {
/// ```
 public struct SectionAlternator2<
    Section1: PrimaryTableSectionMethods,
    Section2: PrimaryTableSectionMethods
>: PrimaryTableSectionMethods, HasInit, SectionAlternator, HasCount, HasRegistrationCandidates
where Section1: HasInit,
      Section2: HasInit {

    public var count: Int {
        currentSection.count
    }

    var section1: Section1 = .init()
    var section2: Section2 = .init()
    public var registerCandidates: [RegistersCells & RegistersHeader] { [section1, section2] }

    public typealias AlternatingLogic = (Section1, Section2) -> PrimaryTableSectionMethods & HasCount
    var alternatingLogic: AlternatingLogic?

    public var currentSection: PrimaryTableSectionMethods & HasCount {
        alternatingLogic?(section1, section2) ?? section1
    }
}
