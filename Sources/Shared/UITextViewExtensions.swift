//
//  UITextViewExtensions.swift
//  Pods
//
//  Created by Brian Strobach on 4/21/16.
//
//

import UIKit

public extension UITextView{
    
    public var fontSize: CGFloat{
        set{
            if let font = self.font{
                self.font = font.withSize(newValue)
            }
            else{
                self.font = UIFont.systemFont(ofSize: newValue)
            }
        }
        get{
            return self.font?.pointSize ?? UIFont.systemFontSize
        }
    }
    
    public var fontName: String{
        set{
            self.font = UIFont(name: newValue, size: fontSize)
        }
        get{
            return self.font?.familyName ?? UIFont.systemFont(ofSize: fontSize).familyName
        }
    }
}
