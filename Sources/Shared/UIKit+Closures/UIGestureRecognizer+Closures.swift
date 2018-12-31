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

extension UIGestureRecognizer: SelectorClosurable & TargetActionable {
    public func onGesture(_ closure: @escaping VoidClosure) {
        bind(closure, via: { [weak self] in
            guard let self = self else { return }
            self.addTarget($0, action: $1)
        })
    }
    public convenience init(closure: @escaping VoidClosure) {
        self.init()
        onGesture(closure)
    }
}
extension SelectorClosurable where Self: UIGestureRecognizer {
    public func onGesture(_ closure: @escaping ClosureIn<Self>) {
        addTargetAction(closure)
    }
    public init(closure: @escaping ClosureIn<Self>) {
        self.init()
        onGesture(closure)
    }
}

#endif
