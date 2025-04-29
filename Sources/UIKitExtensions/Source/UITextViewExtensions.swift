//
//  UITextViewExtensions.swift
//  UIKitExtensions
//
//  Created by Brian Strobach on 4/21/16.
//
//

#if canImport(UIKit)
import UIKit

public extension UITextView {
    
    var fontSize: CGFloat {
        set {
            if let font = self.font {
                self.font = font.withSize(newValue)
            } else {
                self.font = UIFont.systemFont(ofSize: newValue)
            }
        }
        get {
            return self.font?.pointSize ?? UIFont.systemFontSize
        }
    }
    
    var fontName: String {
        set {
            self.font = UIFont(name: newValue, size: fontSize)
        }
        get {
            return self.font?.familyName ?? UIFont.systemFont(ofSize: fontSize).familyName
        }
    }
}
#endif
