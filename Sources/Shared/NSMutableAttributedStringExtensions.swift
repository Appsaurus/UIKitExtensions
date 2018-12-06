//
//  NSMutableAttributedStringExtensions.swift
//  Pods
//
//  Created by Brian Strobach on 9/21/16.
//
//

#if !os(OSX)
import Foundation
import UIKit

public extension NSMutableAttributedString{
    @discardableResult
    public func setFont(_ font: UIFont, range: NSRange? = nil) -> Self{
        addAttribute(.font, value: font, range: range ?? fullRange)
        return self
    }
    @discardableResult
    public func setColor(_ color: UIColor, range: NSRange? = nil) -> Self{
        addAttribute(.foregroundColor, value: color, range: range ?? fullRange)
        return self
    }
    
    public class func attributedString(_ string: String, font: UIFont? = nil, color: UIColor? = nil) -> NSMutableAttributedString{
        let aString = NSMutableAttributedString(string: string)
        if let font = font{
            aString.setFont(font)
        }
        if let color = color{
            aString.setColor(color)
        }
        return aString
    }
    
    
    @discardableResult
    public func addAttribute(_ key: NSAttributedString.Key, value: AnyObject) -> NSMutableAttributedString{
        addAttribute(key, value: value, range: fullRange)
        return self
    }
    
    @discardableResult
    public func addAttributes(_ attrs: [NSAttributedString.Key : AnyObject]) -> NSMutableAttributedString{
        addAttributes(attrs, range: fullRange)
        return self
    }
    
    @discardableResult
    public func appendString(_ string: String) -> NSMutableAttributedString{
        self.append(NSAttributedString(string: string))
        return self
    }
    
    @discardableResult
    public func appendLineBreak(count: Int = 1) -> NSMutableAttributedString{
        for _ in 0...count{
            self.append(NSAttributedString(string: "\n"))
        }
        return self
    }
    
    public convenience init(attributedStrings: [NSAttributedString], separatedByLineBreaks: Bool = false){
        self.init(attributedString: attributedStrings.first!)
        attributedStrings.forEachWithIndex { (index, element) in
            if index != 0{
                if separatedByLineBreaks && index != attributedStrings.count{
                    appendLineBreak()
                }
                append(element)
            }
        }
    }
}

#endif
