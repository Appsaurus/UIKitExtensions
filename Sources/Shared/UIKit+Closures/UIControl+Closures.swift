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

extension UIControl: SelectorClosurable {

    public func on(_ controlEvents: Event, closure: @escaping VoidClosure) {
        bind(closure, via: { [weak self] in
            guard let self = self else { return }
            self.addTarget($0, action: $1, for: controlEvents)
        })
    }
}

extension SelectorClosurable where Self: UIControl {
    public func on(_ controlEvents: Event, closure: @escaping ClosureIn<Self>) {
        bind(closure, via: { [weak self] in
            guard let self = self else { return }
            self.addTarget($0, action: $1, for: controlEvents)
        })
    }
}

#endif
