//
//  UIFontExtensions.swift
//  Pods
//
//  Created by Brian Strobach on 9/14/16.
//
//

#if canImport(UIKit)
import UIKit

public extension UIFont {
    public static func printAvailableFonts() {
        for familyName in UIFont.familyNames as [String] {            
            print("\(familyName)")
            for fontName in UIFont.fontNames(forFamilyName: familyName) as [String] {
                print("\tFont: \(fontName)")
            }
            
        }
    }
    
    public func sizedToFit(text: String, inHeight height: CGFloat) -> UIFont {
        var minFontSize: CGFloat = 2
        var maxFontSize: CGFloat = 100
        var fontSizeAverage: CGFloat = 0
        var textAndLabelHeightDiff: CGFloat = 0

        while minFontSize <= maxFontSize {
            
            fontSizeAverage = minFontSize + (maxFontSize - minFontSize) / 2
            
            // Abort if text happens to be nil
            guard text.count > 0 else {
                break
            }
            
            let labelText: NSString = text as NSString
            let labelHeight = height
            let attributes: [NSAttributedString.Key: Any] =  [.font: withSize(fontSizeAverage)]
            
            let testStringHeight = labelText.size(withAttributes: attributes).height
            
            textAndLabelHeightDiff = labelHeight - testStringHeight
            
            if fontSizeAverage == minFontSize || fontSizeAverage == maxFontSize {
                if textAndLabelHeightDiff < 0 {
                    return withSize(fontSizeAverage - 1)
                }
                return withSize(fontSizeAverage)
            }
            
            if textAndLabelHeightDiff < 0 {
                maxFontSize = fontSizeAverage - 1
                
            } else if textAndLabelHeightDiff > 0 {
                minFontSize = fontSizeAverage + 1
                
            } else {
                return withSize(fontSizeAverage)
            }
        }
        return withSize(fontSizeAverage)
    }
}
#endif
