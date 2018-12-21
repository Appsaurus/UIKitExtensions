//
//  UIViewExtensions.swift
//  UIThemeKit
//
//  Created by Brian Strobach on 11/14/18.
//

#if canImport(UIKit)
import UIKit

public extension UIView {
    
    public func roundCorners() {
        cornerRadius = frame.minSideLength/2.0
    }
    
    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            if newValue > 0 {
                layer.masksToBounds = true
            }
            
        }
    }
    @IBInspectable public var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = (newValue / UIScreen.main.scale)
        }
    }
    @IBInspectable public var borderColor: UIColor? {
        get {
            if let cBorderColor = layer.borderColor {
                return UIColor(cgColor: cBorderColor)
            } else {
                return nil
            }
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
        
    }
    
    public func optimizeSubviews() {
        subviews.forEach { (view) in
            view.optimizeRendering()
        }
    }
    public func optimizeRendering() {
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        layer.isOpaque = true
    }
}
#endif
