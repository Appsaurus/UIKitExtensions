//
//  CALayerExtensions.swift
//  UIKitExtensions
//
//  Created by Brian Strobach on 8/10/16.
//
//

import Foundation
#if canImport(UIKit) && !os(watchOS)
import UIKit
import CoreGraphics

public extension CALayer {
    
    func addGlowingShadow(_ color: UIColor, radius: CGFloat = 5.0, opacity: Float = 1.0, offset: CGSize = CGSize.zero) {
        shadowColor = color.cgColor
        shadowRadius = radius
        shadowOpacity = opacity
        shadowOffset = offset
        masksToBounds = false
    }
    
    func resetShadow() {
        shadowRadius = 3.0
        shadowOpacity = 0.0
        shadowOffset = CGSize(width: 0.0, height: -3.0)
    }
    
    func addBorder(_ edge: UIRectEdge,
                          color: UIColor,
                          thickness: CGFloat,
                          distance: CGFloat = CGFloat(0.0)) -> CALayer {
        var thickness = thickness
        thickness = (thickness / UIScreen.main.scale)
        let border = CALayer()
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: thickness - distance)
        case UIRectEdge.bottom:
            border.frame = CGRect(x: 0, y: self.frame.height - thickness + distance, width: self.frame.width, height: thickness)
        case UIRectEdge.left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.height - distance)
        case UIRectEdge.right:
            border.frame = CGRect(x: self.frame.width - thickness + distance, y: 0, width: thickness, height: self.frame.height)
        default:
            break
        }
        
        border.backgroundColor = color.cgColor
        
        self.addSublayer(border)
        return border
    }
}
#endif
