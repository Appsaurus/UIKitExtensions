//
//  UIEdgeInsetExtensions.swift
//  UIKitExtensions
//
//  Created by Brian Strobach on 10/4/16.
//
//

#if canImport(UIKit)
import UIKit
import Swiftest

public extension UIEdgeInsets {
    init(padding: CGFloat) {
        self.init(top: padding, left: padding, bottom: padding, right: padding)
    }
    
    init(horizontalPadding: CGFloat = 0.0, verticalPadding: CGFloat = 0.0) {
        self.init(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
    }
    
    init(t: CGFloat = 0.0, l: CGFloat = 0.0, b: CGFloat = 0.0, r: CGFloat = 0.0) {
        self.init(top: t, left: l, bottom: b, right: r)
    }
    
    static func padded(_ padding: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(padding: padding)
    }
    
    static func padded(horizontal: CGFloat = 0.0, vertical: CGFloat = 0.0) -> UIEdgeInsets {
        return UIEdgeInsets(horizontalPadding: horizontal, verticalPadding: vertical)
    }
}

extension UIEdgeInsets: ExpressibleByFloatLiteral {
    
    public init(floatLiteral value: Double) {
        self.init(padding: CGFloat(value))
    }
    
    public typealias FloatLiteralType = Double
}

extension UIEdgeInsets: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self.init(padding: CGFloat(value))
    }
    
    public typealias IntegerLiteralType = Int
}

extension UIEdgeInsets: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: CGFloatConvertible...) {
        self.init(t: elements[safe: 0]?.cgFloat ?? 0,
                  l: elements[safe: 1]?.cgFloat ?? 0,
                  b: elements[safe: 2]?.cgFloat ?? 0,
                  r: elements[safe: 3]?.cgFloat ?? 0)
    }
    
    public typealias ArrayLiteralElement = CGFloatConvertible
}

#endif
