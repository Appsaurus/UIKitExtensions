//
//  UIView+BatchGestureRecognizers.swift
//  UIKitExtensions
//
//  Created by Brian Strobach on 12/27/18.
//  Copyright © 2018 Brian Strobach. All rights reserved.
//

#if canImport(UIKit)
import UIKit

public extension UIView {

    public func disableGestureRecognizers() {
        gestureRecognizers?.forEach({ (gr) -> Void in
            gr.isEnabled = false
        })
    }

    public func enableGestureRecognizers() {
        gestureRecognizers?.forEach({ (gr) -> Void in
            gr.isEnabled = true
        })
    }

    public func removeGestureRecognizers() {
        gestureRecognizers?.forEach({ (gr) -> Void in
            self.removeGestureRecognizer(gr)
        })
    }
}
#endif
