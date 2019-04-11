//
//  String+Attributed.swift
//  UIKitExtensions
//
//  Created by Brian Strobach on 12/19/18.
//  Copyright © 2018 Brian Strobach. All rights reserved.
//

import Foundation

#if canImport(Foundation)
import Foundation
#endif

#if canImport(AppKit)
import AppKit
#endif

#if canImport(UIKit)
import UIKit
#endif

public extension String {
    
    #if canImport(UIKit)
    private typealias Font = UIFont
    #endif
    
    #if canImport(Cocoa)
    private typealias Font = NSFont
    #endif
    
    var attributed: NSAttributedString {
        return NSAttributedString(string: self)
    }
    
    func attributed(attributes: [NSAttributedString.Key: Any]) -> NSAttributedString {
        return NSMutableAttributedString(string: self, attributes: attributes)
    }
    
    #if os(iOS) || os(macOS)
    /// Swiftest: Bold string.
    var bold: NSAttributedString {
        return attributed(attributes: [.font: Font.boldSystemFont(ofSize: Font.systemFontSize)])
    }
    #endif
    
    #if canImport(Foundation)
    /// Swiftest: Underlined string
    var underline: NSAttributedString {
        return attributed(attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }
    
    /// Swiftest: Strikethrough string.
    var strikethrough: NSAttributedString {
        return attributed(attributes: [.strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue as Int)])
    }
    #endif
    
    #if canImport(UIKit)
    /// Swiftest: Italic string.
    var italic: NSAttributedString {
        return attributed(attributes: [.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)])
    }
    
    /// Swiftest: Add color to string.
    ///
    /// - Parameter color: text color.
    /// - Returns: a NSAttributedString versions of string colored with given color.
    func colored(with color: UIColor) -> NSAttributedString {
        return attributed(attributes: [.foregroundColor: color])
    }
    #endif
    
    #if canImport(Cocoa)
    /// Swiftest: Add color to string.
    ///
    /// - Parameter color: text color.
    /// - Returns: a NSAttributedString versions of string colored with given color.
    public func colored(with color: NSColor) -> NSAttributedString {
        return attributed(attributes: [.foregroundColor: color])
    }
    #endif
    
}
