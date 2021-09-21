//
//  NSObject.swift
//  TableViewWork
//
//  Created by Scott Lydon on 9/11/21.
//

import Foundation

 extension NSObject {
    @objc public class var className: String {
        String(describing: self)
    }
}
