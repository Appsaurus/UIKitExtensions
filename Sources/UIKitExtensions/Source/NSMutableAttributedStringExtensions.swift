//
//  NSMutableAttributedStringExtensions.swift
//  UIKitExtensions
//
//  Created by Brian Strobach on 9/21/16.
//
//

#if canImport(UIKit)
import UIKit

public extension NSMutableAttributedString {
    @discardableResult
    func setFont(_ font: UIFont, range: NSRange? = nil) -> Self {
        addAttribute(.font, value: font, range: range ?? fullRange)
        return self
    }
    @discardableResult
    func setColor(_ color: UIColor, range: NSRange? = nil) -> Self {
        addAttribute(.foregroundColor, value: color, range: range ?? fullRange)
        return self
    }
    
    class func attributedString(_ string: String,
                                       font: UIFont? = nil,
                                       color: UIColor? = nil) -> NSMutableAttributedString {
        let aString = NSMutableAttributedString(string: string)
        if let font = font {
            aString.setFont(font)
        }
        if let color = color {
            aString.setColor(color)
        }
        return aString
    }
}

public extension NSMutableAttributedString {
    
    /// Vertically centers the baselines all characters of an attributed string, regardless of
    /// differentiating font sizes throughout the string.
    ///
    /// - Parameter additionalOffset: Additional bump to give offset (use in the case where you
    /// might have an icon or char that is not perfectly centered in its own frame)
    /// - Returns: The attriuted string with baseline shift applied
    func verticallyCenterAllCharacters(additionalOffset: CGFloat = 0.0) -> NSMutableAttributedString {
        
        var pointSizes: [CGFloat] = []
        for charIndex in 0...self.length - 1 {
            if let fontSizeAtIndex = (self.attribute(NSAttributedString.Key.font,
                                                     at: charIndex,
                                                     effectiveRange: nil) as AnyObject).pointSize {
                pointSizes.append(fontSizeAtIndex)
            }
        }
        
        pointSizes.removeDuplicates()
        
        let basePointSize: CGFloat = pointSizes.sorted().last! //Adjust offest to meet the largest font's center
        
        for charIndex in 0...self.length - 1 {
            if let fontSize = (self.attribute(NSAttributedString.Key.font,
                                              at: charIndex,
                                              effectiveRange: nil) as AnyObject).pointSize {
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
