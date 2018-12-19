//
//  NSAttributedStringExtensions.swift
//  UIKitExtensions
//
//  Created by Brian Strobach on 12/19/18.
//  Copyright © 2018 Brian Strobach. All rights reserved.
//

#if canImport(UIKit)
import UIKit
#endif

#if canImport(Cocoa)
import Cocoa
#endif

extension NSAttributedString{
    #if os(iOS)
    /// Swiftest: Bolded string.
    public var bolded: NSAttributedString {
        return applying(attributes: [.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)])
    }
    #endif
    
    /// Swiftest: Underlined string.
    public var underlined: NSAttributedString {
        return applying(attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }
    
    #if os(iOS)
    /// Swiftest: Italicized string.
    public var italicized: NSAttributedString {
        return applying(attributes: [.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)])
    }
    #endif
    
    /// Swiftest: Struckthrough string.
    public var struckthrough: NSAttributedString {
        return applying(attributes: [.strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue as Int)])
    }
    
    #if os(macOS)
    /// Swiftest: Add color to NSAttributedString.
    ///
    /// - Parameter color: text color.
    /// - Returns: a NSAttributedString colored with given color.
    public func colored(with color: NSColor) -> NSAttributedString {
        return applying(attributes: [.foregroundColor: color])
    }
    #else
    /// Swiftest: Add color to NSAttributedString.
    ///
    /// - Parameter color: text color.
    /// - Returns: a NSAttributedString colored with given color.
    public func colored(with color: UIColor) -> NSAttributedString {
        return applying(attributes: [.foregroundColor: color])
    }
    #endif
}
