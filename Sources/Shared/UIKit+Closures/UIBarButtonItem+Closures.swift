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

extension UIBarButtonItem: SelectorClosurable & TargetActionable {

    public func addTarget(_ target: Any, action: Selector) {
        self.target = target as AnyObject
        self.action = action
    }
    public func onTap(_ closure: @escaping VoidClosure) {
        addTargetAction(closure)
    }
}
extension SelectorClosurable where Self: UIBarButtonItem {
    public func onTap(_ closure: @escaping ClosureIn<Self>) {
        addTargetAction(closure)
    }
}

#endif
