//
//  ActionDelegatable.swift
//  UIKitExtensions
//
//  Created by Brian Strobach on 1/2/19.
//  Copyright © 2019 Brian Strobach. All rights reserved.
//

#if canImport(Foundation)
import DarkMagic
import Swiftest

public protocol ActionDelegatable: ActionBindable {
    mutating func addAction(binding closure: @escaping VoidClosure, to method: SelectorBindingMethod) -> VoidAction
    mutating func addAction<P>(binding closure: @escaping ClosureIn<P>, to method: SelectorBindingMethod) -> ActionIn<P>
}

private extension AssociatedObjectKeys {
    static let actions = AssociatedObjectKey<[String: Action]>("actions")
}
public extension ActionDelegatable where Self: NSObject {

    public var actions: [String: Action] {
        get {
            return self[.actions, [:]]
        }
        set {
            self[.actions] = newValue
        }
    }
    @discardableResult
    public mutating func addAction(binding closure: @escaping VoidClosure,
                                   to method: SelectorBindingMethod) -> VoidAction {
        let action = bind(closure, to: method)
        actions[action.key] = action
        return action
    }

    @discardableResult
    public mutating func addAction<P>(binding closure: @escaping ClosureIn<P>,
                                      to method: SelectorBindingMethod) -> ActionIn<P> {
        let action = bind(closure, to: method)
        actions[action.key] = action
        return action
    }

    public mutating func remove(action: Action) {
        actions.removeValue(forKey: action.key)
    }
}

#endif
