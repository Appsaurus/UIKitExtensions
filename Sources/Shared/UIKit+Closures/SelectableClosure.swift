//
//  SelectableClosure.swift
//  UIKitExtensions
//
//  Created by Brian Strobach on 12/31/18.
//  Copyright © 2018 Brian Strobach. All rights reserved.
//

#if canImport(ObjectiveC) && canImport(Foundation)
import ObjectiveC
import Foundation
import DarkMagic
import Swiftest

internal class SelectableClosure<T> {
    fileprivate let closure: ClosureIn<T>

    init(_ closure: @escaping ClosureIn<T>) {
        self.closure = closure
    }

    @objc func perform(sender: NSObject) {
        guard let sender = sender as? T else { return }
        closure(sender)
    }
}

public protocol TargetActionable: class {
    func addTarget(_ target: Any, action: Selector)
}

private var selectableClosuresKey: UInt8 = 0

public protocol SelectorClosurable: class {}
public extension SelectorClosurable where Self: NSObject {
    public typealias SelectorBinding = (Any, Selector) -> Void

    internal var selectableClosures: [SelectableClosure<Self>] {
        get {
            return getAssociatedObject(for: &selectableClosuresKey, with: .weak, initialValue: [])
        }
        set {
            setAssociatedObject(newValue, for: &selectableClosuresKey, with: .weak)
        }
    }

    public func bind(_ closure: @escaping ClosureIn<Self>, via binding: SelectorBinding) {
        let actor = SelectableClosure<Self>(closure)
        binding(actor, #selector(SelectableClosure<Self>.perform(sender:)))
        selectableClosures.append(actor)
    }

    public func bind(_ closure: @escaping VoidClosure, via binding: SelectorBinding) {
        let wrappedClosure: ClosureIn<Self> = { _ in
            closure()
        }
        bind(wrappedClosure, via: binding)
    }
}

extension SelectorClosurable where Self: NSObject & TargetActionable {
    public func addTargetAction(_ closure: @escaping ClosureIn<Self>) {
        bind(closure, via: addTarget)
    }

    public func addTargetAction(_ closure: @escaping VoidClosure) {
        bind(closure, via: addTarget)
    }
}

#endif
