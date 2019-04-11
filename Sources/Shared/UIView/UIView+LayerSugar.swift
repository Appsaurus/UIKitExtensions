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
    @IBInspectable var cornerRadius: CGFloat {
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

    func roundCorners() {
        cornerRadius = frame.minSideLength/2.0
    }

    func roundCornersUsingLayerMask(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(side: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

// MARK: Borders
public extension UIView {

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = (newValue / UIScreen.main.scale)
        }
    }
    @IBInspectable var borderColor: UIColor? {
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

    func addBorder(_ width: CGFloat, color: UIColor) {
        layer.borderWidth = width / UIScreen.main.scale
        layer.borderColor = color.cgColor
    }
}

// MARK: Rendering Optimization
public extension UIView {
    func optimizeSubviews() {
        subviews.forEach { (view) in
            view.optimizeRendering()
        }
    }
    func optimizeRendering() {
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        layer.isOpaque = true
    }
}

#endif
