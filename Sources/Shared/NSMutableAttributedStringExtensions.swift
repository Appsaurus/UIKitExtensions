//
//  NSMutableAttributedStringExtensions.swift
//  Pods
//
//  Created by Brian Strobach on 9/21/16.
//
//

#if canImport(UIKit)
import UIKit

public extension NSMutableAttributedString {
    @discardableResult
    public func setFont(_ font: UIFont, range: NSRange? = nil) -> Self {
        addAttribute(.font, value: font, range: range ?? fullRange)
        return self
    }
    @discardableResult
    public func setColor(_ color: UIColor, range: NSRange? = nil) -> Self {
        addAttribute(.foregroundColor, value: color, range: range ?? fullRange)
        return self
    }
    
    public class func attributedString(_ string: String, font: UIFont? = nil, color: UIColor? = nil) -> NSMutableAttributedString {
        let aString = NSMutableAttributedString(string: string)
        if let font = font {
            aString.setFont(font)
        }
        if let color = color {
            aString.setColor(color)
        }
        return aString
    }
    
    @discardableResult
    public func addAttribute(_ key: NSAttributedString.Key, value: AnyObject) -> NSMutableAttributedString {
        addAttribute(key, value: value, range: fullRange)
        return self
    }
    
    @discardableResult
    public func addAttributes(_ attrs: [NSAttributedString.Key: AnyObject]) -> NSMutableAttributedString {
        addAttributes(attrs, range: fullRange)
        return self
    }
    
    @discardableResult
    public func appendString(_ string: String) -> NSMutableAttributedString {
        self.append(NSAttributedString(string: string))
        return self
    }
    
    @discardableResult
    public func appendLineBreak(count: Int = 1) -> NSMutableAttributedString {
        for _ in 0...count {
            self.append(NSAttributedString(string: "\n"))
        }
        return self
    }
}

public extension NSMutableAttributedString {
    
    public convenience init(attributedStrings: [NSAttributedString], separatedByLineBreaks: Bool = false) {
        self.init(attributedString: attributedStrings.first!)
        attributedStrings.enumerated().forEach { (index, element) in
            if index != 0 {
                if separatedByLineBreaks && index != attributedStrings.count {
                    appendLineBreak()
                }
                append(element)
            }
        }
    }
    
    /// Vertically centers the baselines all characters of an attributed string, regardless of differentiating font sizes throughout the string.
    ///
    /// - Parameter additionalOffset: Additional bump to give offset (use in the case where you might have an icon or char that is not perfectly centered in its own frame)
    /// - Returns: The attriuted string with baseline shift applied
    public func verticallyCenterAllCharacters(additionalOffset: CGFloat = 0.0) -> NSMutableAttributedString {
        
        var pointSizes: [CGFloat] = []
        for charIndex in 0...self.length - 1 {
            if let fontSizeAtIndex = (self.attribute(NSAttributedString.Key.font, at: charIndex, effectiveRange: nil) as AnyObject).pointSize {
                pointSizes.append(fontSizeAtIndex)
            }
        }
        
        pointSizes.removeDuplicates()
        
        let basePointSize: CGFloat = pointSizes.sorted().last! //Adjust offest to meet the largest font's center
        
        for charIndex in 0...self.length - 1 {
            if let fontSize = (self.attribute(NSAttributedString.Key.font, at: charIndex, effectiveRange: nil) as AnyObject).pointSize {
                if fontSize == basePointSize {
                    continue
                }
                let shiftHeight = (basePointSize - fontSize)/2.0
                
                let baselineShift = [NSAttributedString.Key.baselineOffset: shiftHeight + additionalOffset]
                let range = Range<Int>(charIndex...charIndex)
                self.addAttributes(baselineShift, range: NSRange(range))
            }
        }
        return self
    }
    
}

#endif
