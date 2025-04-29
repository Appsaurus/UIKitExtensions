//
//  UIBarButtonItemExtensions.swift
//  UIKitExtensions
//
//  Created by Brian Strobach on 4/12/17.
//
//

#if canImport(UIKit)
import UIKit
import Swiftest

extension UIBarButtonItem {
    public var frame: CGRect {
        // swiftlint:disable next force_cast
        return (value(forKey: "view") as! UIView).frame
    }
}
#endif
