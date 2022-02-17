//
//  TargetActionable+Closures.swift
//  UIKitExtensions
//
//  Created by Brian Strobach on 1/2/19.
//  Copyright © 2019 Brian Strobach. All rights reserved.
//

#if canImport(Foundation)
import Swiftest
import Foundation

public protocol TargetActionable: AnyObject {
    func addTarget(_ target: Any, action: Selector)
}

extension ActionDelegatable where Self: NSObject & TargetActionable {
    @discardableResult
    public func addTargetAction(_ closure: @escaping ClosureIn<Self>) -> ActionIn<Self> {
        return addAction(binding: closure, to: addTarget)
    }

    @discardableResult
    public func addTargetAction(_ closure: @escaping VoidClosure) -> VoidAction {
        return addAction(binding: closure, to: addTarget)
    }
}
#endif
