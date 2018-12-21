//
//  UIScreenExtensions.swift
//  Pods
//
//  Created by Brian Strobach on 6/30/16.
//
//

#if canImport(UIKit)
import UIKit

public extension UIScreen {
    public static var screenWidth: CGFloat {
        return screenSize.width
    }
    
    public static var screenHeight: CGFloat {
        return screenSize.height
    }
    
    public static var screenSize: CGSize {
        return screenBounds.size
    }
    
    public static var screenBounds: CGRect {
        return UIScreen.main.bounds
    }
    
}
#endif
