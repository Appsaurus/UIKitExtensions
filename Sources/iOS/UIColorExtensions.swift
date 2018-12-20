////
////  UIColorExtensions.swift
////  Pods
////
////  Created by Brian Strobach on 8/10/16.
////
////
//
//import Foundation
//#if canImport(UIKit)
//import UIKit
//import Swiftest
//public extension UIColor {
//    
//    public class func randomColor() -> UIColor{
//        let red = CGFloat(drand48())
//        let green = CGFloat(drand48())
//        let blue = CGFloat(drand48())
//        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
//    }
//    
//    
////    /// init method with RGB values from 0 to 255, instead of 0 to 1. With alpha(default:1)
////    public convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) {
////        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
////    }
////    
//    /// Red component of UIColor (get-only)
//    public var redComponent: Int {
//        var r: CGFloat = 0
//        getRed(&r, green: nil, blue: nil, alpha: nil)
//        return Int(r * 255)
//    }
//    
//    /// Green component of UIColor (get-only)
//    public var greenComponent: Int {
//        var g: CGFloat = 0
//        getRed(nil, green: &g, blue: nil, alpha: nil)
//        return Int(g * 255)
//    }
//    
//    /// blue component of UIColor (get-only)
//    public var blueComponent: Int {
//        var b: CGFloat = 0
//        getRed(nil, green: nil, blue: &b, alpha: nil)
//        return Int(b * 255)
//    }
//    
//    /// Alpha of UIColor (get-only)
//    public var alpha: Int {
//        var a: CGFloat = 0
//        getRed(nil, green: nil, blue: nil, alpha: &a)
//        return Int(a)
//    }
//
//    /**
//     Returns a lighter color by the provided percentage
//
//     :param: lighting percent percentage
//     :returns: lighter UIColor
//     */
//    public func lighterColor(_ percent : Double) -> UIColor {
//        return colorWithBrightnessFactor(CGFloat(1 + percent));
//    }
//
//    /**
//     Returns a darker color by the provided percentage
//
//     :param: darking percent percentage
//     :returns: darker UIColor
//     */
//    public func darkerColor(_ percent : Double) -> UIColor {
//        return colorWithBrightnessFactor(CGFloat(1 - percent));
//    }
//
//    /**
//     Return a modified color using the brightness factor provided
//
//     :param: factor brightness factor
//     :returns: modified color
//     */
//    public func colorWithBrightnessFactor(_ factor: CGFloat) -> UIColor {
//        var hue : CGFloat = 0
//        var saturation : CGFloat = 0
//        var brightness : CGFloat = 0
//        var alpha : CGFloat = 0
//
//        if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
//            return UIColor(hue: hue, saturation: saturation, brightness: brightness * factor, alpha: alpha)
//        } else {
//            return self;
//        }
//    }
//
//    public func brighten(amount: CGFloat) -> UIColor{
//        return self.colorWithBrightnessFactor(brightnessComponent + amount)
//    }
//
//    public class func hsb(_ h: CGFloat, _ s: CGFloat, _ b: CGFloat, _ a: CGFloat = 1.0) -> UIColor{
//        return UIColor(hue: h/360.0, saturation: s/100.0, brightness: b/100.0, alpha: a)
//    }
//}
//
//
////  Created by R0CKSTAR on 6/13/14.
////  Copyright (c) 2014 P.D.Q. All rights reserved.
////
//
///**
// MissingHashMarkAsPrefix:   "Invalid RGB string, missing '#' as prefix"
// UnableToScanHexValue:      "Scan hex error"
// MismatchedHexStringLength: "Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8"
// */
//public enum UIColorInputError : Error {
//    case missingHashMarkAsPrefix,
//    unableToScanHexValue,
//    mismatchedHexStringLength
//}
//
//extension UIColor {
//
//
//    /**
//     The shorthand three-digit hexadecimal representation of color.
//     #RGB defines to the color #RRGGBB.
//     
//     - parameter hex3: Three-digit hexadecimal value.
//     - parameter alpha: 0.0 - 1.0. The default is 1.0.
//     */
//    public convenience init(hex3: UInt16, alpha: CGFloat = 1) {
//        let divisor = CGFloat(15)
//        let red     = CGFloat((hex3 & 0xF00) >> 8) / divisor
//        let green   = CGFloat((hex3 & 0x0F0) >> 4) / divisor
//        let blue    = CGFloat( hex3 & 0x00F      ) / divisor
//        self.init(red: red, green: green, blue: blue, alpha: alpha)
//    }
//    
//    /**
//     The shorthand four-digit hexadecimal representation of color with alpha.
//     #RGBA defines to the color #RRGGBBAA.
//     
//     - parameter hex4: Four-digit hexadecimal value.
//     */
//    public convenience init(hex4: UInt16) {
//        let divisor = CGFloat(15)
//        let red     = CGFloat((hex4 & 0xF000) >> 12) / divisor
//        let green   = CGFloat((hex4 & 0x0F00) >>  8) / divisor
//        let blue    = CGFloat((hex4 & 0x00F0) >>  4) / divisor
//        let alpha   = CGFloat( hex4 & 0x000F       ) / divisor
//        self.init(red: red, green: green, blue: blue, alpha: alpha)
//    }
//    
//    /**
//     The six-digit hexadecimal representation of color of the form #RRGGBB.
//     
//     - parameter hex6: Six-digit hexadecimal value.
//     */
//    public convenience init(hex6: UInt32, alpha: CGFloat = 1) {
//        let divisor = CGFloat(255)
//        let red     = CGFloat((hex6 & 0xFF0000) >> 16) / divisor
//        let green   = CGFloat((hex6 & 0x00FF00) >>  8) / divisor
//        let blue    = CGFloat( hex6 & 0x0000FF       ) / divisor
//        self.init(red: red, green: green, blue: blue, alpha: alpha)
//    }
//    
//    /**
//     The six-digit hexadecimal representation of color with alpha of the form #RRGGBBAA.
//     
//     - parameter hex8: Eight-digit hexadecimal value.
//     */
//    public convenience init(hex8: UInt32) {
//        let divisor = CGFloat(255)
//        let red     = CGFloat((hex8 & 0xFF000000) >> 24) / divisor
//        let green   = CGFloat((hex8 & 0x00FF0000) >> 16) / divisor
//        let blue    = CGFloat((hex8 & 0x0000FF00) >>  8) / divisor
//        let alpha   = CGFloat( hex8 & 0x000000FF       ) / divisor
//        self.init(red: red, green: green, blue: blue, alpha: alpha)
//    }
//    
//    /**
//     The rgba string representation of color with alpha of the form #RRGGBBAA/#RRGGBB, throws error.
//     
//     - parameter rgba: String value.
//     */
//    public convenience init(rgba_throws rgba: String) throws {
//        guard rgba.hasPrefix("#") else {
//            throw UIColorInputError.missingHashMarkAsPrefix
//        }
//        let hexString: String = String(rgba[rgba.index(rgba.startIndex, offsetBy: 1)..<rgba.endIndex])
//        var hexValue:  UInt32 = 0
//        guard Scanner(string: hexString).scanHexInt32(&hexValue) else {
//                throw UIColorInputError.unableToScanHexValue
//        }
//        
//        switch (hexString.count) {
//        case 3:
//            self.init(hex3: UInt16(hexValue))
//        case 4:
//            self.init(hex4: UInt16(hexValue))
//        case 6:
//            self.init(hex6: hexValue)
//        case 8:
//            self.init(hex8: hexValue)
//        default:
//            throw UIColorInputError.mismatchedHexStringLength
//        }
//    }
//    
//    /**
//     The rgba string representation of color with alpha of the form #RRGGBBAA/#RRGGBB, fails to default color.
//     
//     - parameter rgba: String value.
//     */
//    public convenience init(rgba: String, defaultColor: UIColor = UIColor.clear) {
//        guard let color = try? UIColor(rgba_throws: rgba) else {
//            self.init(cgColor: defaultColor.cgColor)
//            return
//        }
//        self.init(cgColor: color.cgColor)
//    }
//    
//    /**
//     Hex string of a UIColor instance.
//     
//     - parameter rgba: Whether the alpha should be included.
//     */
//    public func hexString(_ includeAlpha: Bool) -> String {
//        var r: CGFloat = 0
//        var g: CGFloat = 0
//        var b: CGFloat = 0
//        var a: CGFloat = 0
//        self.getRed(&r, green: &g, blue: &b, alpha: &a)
//        
//        if (includeAlpha) {
//            return String(format: "#%02X%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255), Int(a * 255))
//        } else {
//            return String(format: "#%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
//        }
//    }
//    
//    
//    open override var description: String {
//        return self.hexString(true)
//    }
//    
//    open override var debugDescription: String {
//        return self.hexString(true)
//    }
//}
//
