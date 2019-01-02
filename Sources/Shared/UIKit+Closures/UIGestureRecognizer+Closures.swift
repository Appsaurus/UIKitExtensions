//
//  UIGestureRecognizer+Closures.swift
//  UIKitExtensions
//
//  Created by Brian Strobach on 12/31/18.
//  Copyright © 2018 Brian Strobach. All rights reserved.
//

#if canImport(UIKit)
import UIKit
import Swiftest

extension UIGestureRecognizer: TargetActionable {}
extension ActionDelegatable where Self: UIGestureRecognizer {

    public init(closure: @escaping VoidClosure) {
        self.init()
        onGesture(closure)
    }

    @discardableResult
    public mutating func onGesture(_ closure: @escaping VoidClosure) -> VoidAction {
        return addTargetAction(closure)
    }

    public init(closure: @escaping ClosureIn<Self>) {
        self.init()
        onGesture(closure)
    }

    @discardableResult
    public mutating func onGesture(_ closure: @escaping ClosureIn<Self>) -> ActionIn<Self> {
        return addTargetAction(closure)
    }
}

#endif
