//
//  UIInterfaceOrientationExtensions.swift
//  UIKitExtensions
//
//  Created by Brian Strobach on 8/25/17.
//
//

#if canImport(UIKit) && !os(tvOS)
import UIKit

open class Orientation {
    public static var orientation: UIInterfaceOrientation {
        return UIApplication.shared.statusBarOrientation
    }
    
    public static var isPortrait: Bool {
        return orientation.isPortrait
    }
    
    public static var isLandscape: Bool {
        return orientation.isLandscape
    }
    
}
extension UIInterfaceOrientation {
    
    public func toMask(allowFlipOnAxis: Bool = true) -> UIInterfaceOrientationMask {
        switch self {
        case .portraitUpsideDown:
            return allowFlipOnAxis ? [.portrait, .portraitUpsideDown] : [.portraitUpsideDown]
        case .portrait:
            return allowFlipOnAxis ? [.portrait, .portraitUpsideDown] : [.portrait]
        case .landscapeRight:
            return allowFlipOnAxis ? [.landscapeLeft, .landscapeRight] : [.landscapeRight]
        case .landscapeLeft:
            return allowFlipOnAxis ? [.landscapeLeft, .landscapeRight] : [.landscapeLeft]
        case .unknown:
            return [.portrait]
        @unknown default:
            fatalError()
        }
    }
    
}
#endif
