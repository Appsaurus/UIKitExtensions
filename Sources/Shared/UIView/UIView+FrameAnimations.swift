//
//  UIView+FrameAnimations.swift
//  UIKitExtensions
//
//  Created by Brian Strobach on 12/27/18.
//  Copyright © 2018 Brian Strobach. All rights reserved.
//

#if canImport(UIKit)
import UIKit

public extension UIView {

    public static var mainWindow: UIWindow {
        return UIApplication.mainWindow
    }
    public func frame(in view: UIView) -> CGRect {
        return frameConvertedToCoordinateSpace(of: view)
    }

    public func frameConvertedToCoordinateSpace(of view: UIView) -> CGRect {
        let immediateParent = superview ?? .mainWindow
        return immediateParent.convert(frame, to: view.superview ?? .mainWindow)
    }

    /**
     Moves view from current superview to main window, maintaining position.

     - returns: New frame coordinates in window coordinate space
     */
    @discardableResult
    public func moveToMainWindow() -> CGRect {
        if superview === UIApplication.mainWindow { return frame}
        let mainWindowFrame = self.frameInMainWindow
        UIApplication.mainWindow.addSubview(self)
        self.frame = mainWindowFrame
        //self.bounds.size = frameInMainWindow.size
        //self.center = frameInMainWindow.center
        return mainWindowFrame
    }

    public var frameInMainWindow: CGRect {
        guard let superview = superview, superview !== UIApplication.mainWindow else { return frame }
        return superview.convert(frame, to: .mainWindow)
    }
    
    public func moveToFront() {
        superview?.bringSubviewToFront(self)
    }
}
#endif
