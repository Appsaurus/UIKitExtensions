//
//  UIViewExtensions.swift
//  UIThemeKit
//
//  Created by Brian Strobach on 11/14/18.
//

#if canImport(UIKit)
import UIKit

// MARK: Corner Rounding
public extension UIView {
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

    public func roundCorners() {
        cornerRadius = frame.minSideLength/2.0
    }

    public func roundCornersUsingLayerMask(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(side: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

// MARK: Borders
public extension UIView {

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

    public func addBorder(_ width: CGFloat, color: UIColor) {
        layer.borderWidth = width / UIScreen.main.scale
        layer.borderColor = color.cgColor
    }
}

// MARK: Rendering Optimization
public extension UIView {
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
