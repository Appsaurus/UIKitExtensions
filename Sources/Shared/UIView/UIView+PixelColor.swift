//
//  UIView+PixelColor.swift
//  UIKitExtensions
//
//  Created by Brian Strobach on 12/28/18.
//  Copyright © 2018 Brian Strobach. All rights reserved.
//

#if canImport(UIKit)
import UIKit

public extension UIView {
    public func color(at point: CGPoint) -> UIColor {

        var pixel: [CUnsignedChar] = [0, 0, 0, 0]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: &pixel, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)

        context!.translateBy(x: -point.x, y: -point.y)
        layer.render(in: context!)

        let red: CGFloat   = CGFloat(pixel[0]) / 255.0
        let green: CGFloat = CGFloat(pixel[1]) / 255.0
        let blue: CGFloat  = CGFloat(pixel[2]) / 255.0
        let alpha: CGFloat = CGFloat(pixel[3]) / 255.0

        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    public func alpha(at point: CGPoint) -> CGFloat {
        return color(at: point).rgba.alpha
    }

    public func hasAlphaAtPoint(_ point: CGPoint) -> Bool {
        return alpha(at: point) > 0.0
    }
}

#endif
