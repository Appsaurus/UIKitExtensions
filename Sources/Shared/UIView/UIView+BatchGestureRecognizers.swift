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

    func disableGestureRecognizers() {
        gestureRecognizers?.forEach({ (gr) -> Void in
            gr.isEnabled = false
        })
    }

    func enableGestureRecognizers() {
        gestureRecognizers?.forEach({ (gr) -> Void in
            gr.isEnabled = true
        })
    }

    func removeGestureRecognizers() {
        gestureRecognizers?.forEach({ (gr) -> Void in
            self.removeGestureRecognizer(gr)
        })
    }
}
#endif
