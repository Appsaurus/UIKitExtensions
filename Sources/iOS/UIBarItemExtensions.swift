//
//  UIBarItemExtensions.swift
//  Pods
//
//  Created by Brian Strobach on 9/14/16.
//
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension UIBarItem{
    public func setTitleTextAttributes(_ attributes: [NSAttributedString.Key : AnyObject]?, forStates states: UIControl.State...){
        states.forEach { (state) in
            setTitleTextAttributes(attributes, for: state)
        }
    }
    
    public func setAttributed(font: UIFont? = nil, textColor: UIColor? = nil, title: String? = nil, forState state: UIControl.State){
        var attributes: [NSAttributedString.Key : AnyObject] = [:]
        if let font = font{
            attributes[.font] = font
        }
        if let textColor = textColor{
            attributes[.foregroundColor] = textColor
        }
        setTitleTextAttributes(attributes, for: state)
        if let title = title{
            self.title = title
        }
    }
    
    public func setAttributed(font: UIFont? = nil, textColor: UIColor? = nil, title: String? = nil, forStates states: UIControl.State...){
        states.forEach { (state) in
            setAttributed(font: font, textColor: textColor, title: title, forState: state)
        }
    }
}
#endif
