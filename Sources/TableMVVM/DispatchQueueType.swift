//
//  DispatchQueueType.swift
//  TableViewWorkTests
//
//  Created by Scott Lydon on 9/19/21.
//

import Foundation

 public protocol DispatchQueueType {
    func async(execute work: @escaping @convention(block) () -> Void)
}

extension DispatchQueue: DispatchQueueType {
    public func async(execute work: @escaping @convention(block) () -> Void) {
         async(group: nil, qos: .unspecified, flags: [], execute: work)
     }
}

 final public class DispatchQueueMock: DispatchQueueType {
    public func async(execute work: @escaping @convention(block) () -> Void) {
        work()
    }
}
