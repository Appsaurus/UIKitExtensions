//
//  UIView+ViewHeirarchy.swift
//  UIKitExtensions
//
//  Created by Brian Strobach on 12/27/18.
//  Copyright © 2018 Brian Strobach. All rights reserved.
//

#if canImport(UIKit)
import UIKit

public typealias ViewTest = (_ viewToCheck: UIView) -> Bool

// MARK: Subviews

extension UIView {
    public func subviews(recursive: Bool = true, matching check: ViewTest) -> [UIView] {
        var matches: [UIView] = []
        subviews.forEach { (view) in
            if check(view) {
                matches.append(view)
            }
            if recursive && view.subviews.count > 0 {
                matches.append(contentsOf: view.subviews(matching: check))
            }
        }
        return matches
    }

    public func firstSubview(recursive: Bool = true, matching check: ViewTest) -> UIView? {
        guard subviews.count > 0 else { return nil }
        for view in subviews {
            if check(view) {
                return view
            }
            if recursive && view.subviews.count > 0 {
                if let recursiveMatch = view.firstSubview(matching: check) {
                    return recursiveMatch
                }
            }
        }
        return nil
    }

    public func subviews<T: UIView>(ofType type: T.Type, recursive: Bool = true) -> [T] {
        return subviews(recursive: recursive, matching: {$0 is T}).map {$0 as? T}.removeNils()
    }
}

// MARK: Parent

extension UIView {
    public func firstParentView(matching check: ViewTest) -> UIView? {
        var currentView: UIView? = self
        while let viewToTest = currentView?.superview {
            if check(viewToTest) {
                return viewToTest
            }
            currentView = viewToTest
        }
        return nil
    }

    public var firstVisibleParentBackgroundColor: UIColor? {
        return firstParentView(matching: { (view) -> Bool in
            view.backgroundColor != nil
        })?.backgroundColor
    }
}

// MARK: First Responder
extension UIView {
    public var firstResponder: UIView? {
        return firstSubview(matching: {$0.isFirstResponder})
    }
}

#endif
