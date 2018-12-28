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

//Overloading addition operator

public func + (lhs: AlertActionTitle, rhs: @autoclosure @escaping () -> Void) -> UIAlertAction {
    return UIAlertAction(title: lhs, closure: rhs)
}

public func + (lhs: UIAlertAction, rhs: @autoclosure @escaping () -> Void) -> UIAlertAction {
    return UIAlertAction(title: lhs.title, style: lhs.style, closure: rhs)
}

public func + (lhs: (AlertActionTitle, UIAlertAction.Style), rhs: @autoclosure @escaping () -> Void) -> UIAlertAction {
    return UIAlertAction(title: lhs.0, style: lhs.1, closure: rhs)
}

precedencegroup AlertStylePrecedence {
    higherThan: AdditionPrecedence
    associativity: left

}

infix operator ~ : AlertStylePrecedence

public func ~ (lhs: AlertActionTitle, rhs: UIAlertAction.Style) -> UIAlertAction {
    return UIAlertAction(title: lhs, style: rhs)
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
#endif
