//
//  UIViewController+PresentationAwareness.swift
//  UIKitExtensions
//
//  Created by Brian Strobach on 12/28/18.
//  Copyright © 2018 Brian Strobach. All rights reserved.
//

#if canImport(UIKit)
import UIKit

extension UIViewController {
    public var isModal: Bool {
        guard presentingViewController == nil else {
            return true
        }
        return false
    }

    public var isCurrentlyPresentedToUser: Bool {
        return self.isViewLoaded && view.window != nil
    }

    public var isCurrentlyVisibleToUser: Bool {
        return isCurrentlyPresentedToUser && view.isVisible
    }
}

#endif
