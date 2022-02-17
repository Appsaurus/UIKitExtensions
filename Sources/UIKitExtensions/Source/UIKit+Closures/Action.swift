//
//  SelectableClosure.swift
//  UIKitExtensions
//
//  Created by Brian Strobach on 12/31/18.
//  Copyright © 2018 Brian Strobach. All rights reserved.
//

#if canImport(Foundation)
import Foundation
import Swiftest

public typealias SelectorBindingMethod = (Any, Selector) -> Void

public protocol Action {
    var key: String { get }
    var selector: Selector { get }

    func bind(to method: SelectorBindingMethod) -> Self
}

extension Action {

    @discardableResult
    public func bind(to method: SelectorBindingMethod) -> Self {
        method(self, selector)
        return self
    }
}

public class VoidAction: Action {

    public let key = UUID().uuidString
    public let selector: Selector = #selector(perform)

    fileprivate let closure: VoidClosure

    public init(_ closure: @escaping VoidClosure) {
        self.closure = closure
    }

    @objc func perform() {
        closure()
    }
}

public class ActionIn<T>: Action {

    public let key = UUID().uuidString
    public let selector: Selector = #selector(perform)

    fileprivate let closure: ClosureIn<T>

    public init(_ closure: @escaping ClosureIn<T>) {
        self.closure = closure
    }

    public convenience init(_ closure: @escaping VoidClosure) {
        let wrappedClosure: ClosureIn<T> = { _ in
            closure()
        }
        self.init(wrappedClosure)
    }

    @objc func perform(sender: NSObject) {
        guard let sender = sender as? T else { return }
        closure(sender)
    }
}

public protocol ActionBindable: AnyObject {}

public extension ActionBindable {
    func bind<T>(_ closure: @escaping ClosureIn<T>,
                        to method: SelectorBindingMethod) -> ActionIn<T> {
        return ActionIn<T>(closure).bind(to: method)
    }

    func bind(_ closure: @escaping VoidClosure,
                     to method: SelectorBindingMethod) -> VoidAction {
        return VoidAction(closure).bind(to: method)
    }
}
#endif
