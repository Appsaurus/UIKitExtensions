//
//  UIAlertController+ActionSugar.swift
//  UIKitExtensions
//
//  Created by Brian Strobach on 12/28/18.
//  Copyright © 2018 Brian Strobach. All rights reserved.
//

#if canImport(UIKit)
import UIKit
import Swiftest

open class TitledAction {
    public var title: String
    public var action: () -> Void

    public init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
}

extension TitledAction: UIAlertActionConvertible {
    public var toAlertAction: UIAlertAction {
        return UIAlertAction(title: title, closure: action)
    }
}

public typealias AlertActionTitle = String
public protocol UIAlertActionConvertible {
    var toAlertAction: UIAlertAction { get }
}

extension AlertActionTitle: UIAlertActionConvertible {
    public var toAlertAction: UIAlertAction {
        return UIAlertAction(title: self)
    }
}

extension UIAlertAction: UIAlertActionConvertible {
    public var toAlertAction: UIAlertAction {
        return self
    }

    public convenience init(title: String?, style: Style = .default, closure: VoidClosure?) {
        self.init(title: title, style: style, handler: {(_) in
            closure?()
        })
    }
}

extension UIAlertController {
    public func add(actions: [UIAlertAction]) {
        actions.forEach {addAction($0)}
    }
    public func add(actions: UIAlertAction...) {
        add(actions: actions)
    }

    public convenience init(preferredStyle: Style = .alert,
                            title: String? = nil,
                            message: String? = nil,
                            actions: UIAlertActionConvertible...) {
        self.init(preferredStyle: preferredStyle, title: title, message: message, actions: actions)
    }

    public convenience init(preferredStyle: Style = .alert,
                            title: String? = nil,
                            message: String? = nil,
                            actions: [UIAlertActionConvertible]) {
        self.init(title: title, message: message, preferredStyle: preferredStyle)
        add(actions: actions.map {$0.toAlertAction})
    }
}
extension UIAlertAction {
    public convenience init(title: String?) {
        self.init(title: title, style: .default)
    }
    public convenience init(title: String?,
                            style: UIAlertAction.Style = .default,
                            closure: @escaping () -> Void) {
        self.init(title: title, style: style, handler: {(_) in
            closure()
        })
    }
}

// MARK: Operators

//Overloading function mapping operator

public func => (lhs: String, rhs: @escaping () -> Void) -> TitledAction {
    return TitledAction(title: lhs, action: rhs)
}

public func => (lhs: String, rhs: @autoclosure @escaping () -> Void) -> TitledAction {
    return TitledAction(title: lhs, action: rhs)
}

public func => (lhs: UIAlertAction, rhs: @escaping () -> Void) -> UIAlertAction {
    return UIAlertAction(title: lhs.title, style: lhs.style, closure: rhs)
}

public func => (lhs: UIAlertAction, rhs: @autoclosure @escaping () -> Void) -> UIAlertAction {
    return UIAlertAction(title: lhs.title, style: lhs.style, closure: rhs)
}

precedencegroup StyleOperatorPrecedence {
    associativity: right
    higherThan: MapOperatorPrecedence
}
infix operator .~: StyleOperatorPrecedence

/// Example: let action: UIAlertAction = "Delete" .~ .destructive
///
/// - Parameters:
///   - lhs: A title for the UIAlertAction
///   - rhs: An UIAlertAction Style to apply to the title.
/// - Returns: UIAlertAction with title and style applied.
public func .~ (lhs: String, rhs: UIAlertAction.Style) -> UIAlertAction {
    return UIAlertAction(title: lhs, style: rhs)
}

#endif
