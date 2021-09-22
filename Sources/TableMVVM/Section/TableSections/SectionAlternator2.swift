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

    public var section1: Section1 = .fallBack
    public var section2: Section2 = .fallBack
    public var alternatingLogic: AlternatingLogic?

    public init(
        section1: Section1 = .fallBack,
        section2: Section2 = .fallBack,
        alternatingLogic: AlternatingLogic? = nil
    ) {
        self.section1 = section1
        self.section2 = section2
        self.alternatingLogic = alternatingLogic
    }

    public var registerCandidates: [RegistersCells & RegistersHeader] { [section1, section2] }

    public typealias AlternatingLogic = (Section1, Section2) -> PrimaryTableSectionMethods & HasCount

    public var currentSection: PrimaryTableSectionMethods & HasCount {
        alternatingLogic?(section1, section2) ?? section1
    }
}
