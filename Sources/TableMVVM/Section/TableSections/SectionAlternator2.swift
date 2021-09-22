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
>: PrimaryTableSectionMethods, HasFallBack, SectionAlternator, HasCount, HasRegistrationCandidates
where Section1: HasFallBack,
      Section2: HasFallBack {

    public var count: Int {
        currentSection.count
    }

    public static var fallBack: Self { .init() }

    var section1: Section1 = .fallBack
    var section2: Section2 = .fallBack
    public var registerCandidates: [RegistersCells & RegistersHeader] { [section1, section2] }

    public typealias AlternatingLogic = (Section1, Section2) -> PrimaryTableSectionMethods & HasCount
    var alternatingLogic: AlternatingLogic?

    public var currentSection: PrimaryTableSectionMethods & HasCount {
        alternatingLogic?(section1, section2) ?? section1
    }
}
