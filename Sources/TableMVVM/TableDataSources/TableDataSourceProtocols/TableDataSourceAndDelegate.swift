//
//  TableDataSourceAndDelegate.swift
//  
//
//  Created by Scott Lydon on 9/23/21.
//

import UIKit

public typealias TableDataSourceAndDelegate = NSObject & EnsureTableDataSourceMethods & HasRegistrationCandidates & HasTable
