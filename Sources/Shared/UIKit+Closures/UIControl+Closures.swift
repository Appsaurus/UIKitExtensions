//
//  UIControl+Closures.swift
//  UIKitExtensions
//
//  Created by Brian Strobach on 12/31/18.
//  Copyright © 2018 Brian Strobach. All rights reserved.
//

#if canImport(UIKit)
import UIKit
import Swiftest

extension ActionDelegatable where Self: UIControl {

    @discardableResult
    public func addAction(_ closure: @escaping VoidClosure) -> VoidAction {
        return on(.primaryActionTriggered, closure: closure)
    }

    @discardableResult
    public  func addAction(_ closure: @escaping ClosureIn<Self>) -> ActionIn<Self> {
        return on(.primaryActionTriggered, closure: closure)
    }

    @discardableResult
    public  func on(_ controlEvents: Event, closure: @escaping VoidClosure) -> VoidAction {
        return addAction(binding: closure, to: { [weak self] (target, action) in
            guard let self = self else { return }
            self.addTarget(target, action: action, for: controlEvents)
        })
    }

    @discardableResult
    public  func on(_ controlEvents: Event, closure: @escaping ClosureIn<Self>) -> ActionIn<Self> {
        return addAction(binding: closure, to: { [weak self] (target, action) in
            guard let self = self else { return }
            self.addTarget(target, action: action, for: controlEvents)
        })
    }
}

#endif
