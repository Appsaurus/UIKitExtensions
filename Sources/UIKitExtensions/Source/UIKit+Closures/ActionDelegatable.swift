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
import ObjectiveC

public protocol ActionDelegatable: ActionBindable {
    func addAction(binding closure: @escaping VoidClosure, to method: SelectorBindingMethod) -> VoidAction
    func addAction<P>(binding closure: @escaping ClosureIn<P>, to method: SelectorBindingMethod) -> ActionIn<P>
}

private extension AssociatedObjectKeys {
    static let actions = AssociatedObjectKey<[String: Action]>("actions")
}
public extension ActionDelegatable where Self: NSObject {

    var actions: [String: Action] {
        get {
            return self[AssociatedObjectKeys.actions, [:]]
        }
        set {
            self[AssociatedObjectKeys.actions] = newValue
        }
    }
    @discardableResult
    func addAction(binding closure: @escaping VoidClosure,
                          to method: SelectorBindingMethod) -> VoidAction {
        let action = bind(closure, to: method)
        actions[action.key] = action
        return action
    }

    @discardableResult
    func addAction<P>(binding closure: @escaping ClosureIn<P>,
                             to method: SelectorBindingMethod) -> ActionIn<P> {
        let action = bind(closure, to: method)
        actions[action.key] = action
        return action
    }

    func remove(action: Action) {
        actions.removeValue(forKey: action.key)
    }
}

#endif
