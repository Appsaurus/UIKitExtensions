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
    static var screenWidth: CGFloat {
        return screenSize.width
    }
    
    static var screenHeight: CGFloat {
        return screenSize.height
    }
    
    static var screenSize: CGSize {
        return screenBounds.size
    }
    
    static var screenBounds: CGRect {
        return UIScreen.main.bounds
    }
    
}
#endif
