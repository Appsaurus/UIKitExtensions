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
            roundCorners(.allCorners, radius: newValue)
//            layer.cornerRadius = newValue
//            if newValue > 0 {
//                layer.masksToBounds = true
//            }
        }
    }

    func roundCorners() {
        cornerRadius = frame.minSideLength/2.0
    }

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        roundCorners(corners.toCACornerMask, radius: radius)
    }
    func roundCorners(_ corners: CACornerMask, radius: CGFloat) {
        if #available(iOS 11, *) {
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = corners
        } else {
            var cornerMask = corners.toUIRectCorner
            let path = UIBezierPath(roundedRect: self.bounds,
                                    byRoundingCorners: cornerMask,
                                    cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
        
//        if radius > 0 {
//            layer.masksToBounds = true
//        }
    }
}
public extension UIRectCorner {
    var toCACornerMask: CACornerMask {
        var cornerMask = CACornerMask()
        if(contains(.topLeft)){
            cornerMask.insert(.layerMinXMinYCorner)
        }
        if(contains(.topRight)){
            cornerMask.insert(.layerMaxXMinYCorner)
        }
        if(contains(.bottomLeft)){
            cornerMask.insert(.layerMinXMaxYCorner)
        }
        if(contains(.bottomRight)){
            cornerMask.insert(.layerMaxXMaxYCorner)
        }
        return cornerMask
    }
}

public extension CACornerMask {
    var toUIRectCorner: UIRectCorner {
        var cornerMask = UIRectCorner()
        if(contains(.layerMinXMinYCorner)){
            cornerMask.insert(.topLeft)
        }
        if(contains(.layerMaxXMinYCorner)){
            cornerMask.insert(.topRight)
        }
        if(contains(.layerMinXMaxYCorner)){
            cornerMask.insert(.bottomLeft)
        }
        if(contains(.layerMaxXMaxYCorner)){
            cornerMask.insert(.bottomRight)
        }
        return cornerMask
    }
}

public extension UIRectCorner {
    static var top: UIRectCorner = [.topLeft, .topRight]
    static var left: UIRectCorner = [.topLeft, .bottomLeft]
    static var bottom: UIRectCorner = [.bottomLeft, .bottomRight]
    static var right: UIRectCorner = [.topRight, .bottomRight]
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
