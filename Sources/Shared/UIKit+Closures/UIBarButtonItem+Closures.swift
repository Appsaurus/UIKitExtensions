//
//  UIBarButtonItem+Closures.swift
//  UIKitExtensions
//
//  Created by Brian Strobach on 12/31/18.
//  Copyright © 2018 Brian Strobach. All rights reserved.
//

#if canImport(UIKit)
import UIKit
import Swiftest

extension UIBarButtonItem: TargetActionable {

    public func addTarget(_ target: Any, action: Selector) {
        self.target = target as AnyObject
        self.action = action
    }
}
extension ActionDelegatable where Self: UIBarButtonItem {

    @discardableResult
    public mutating func onTap(_ closure: @escaping VoidClosure) -> VoidAction {
        return addTargetAction(closure)
    }

    @discardableResult
    public mutating  func onTap(_ closure: @escaping ClosureIn<Self>) -> ActionIn<Self> {
        return addTargetAction(closure)
    }
}

#endif
