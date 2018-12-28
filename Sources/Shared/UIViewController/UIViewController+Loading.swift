//
//  UIViewControllerExtensions.swift
//  Pods
//
//  Created by Brian Strobach on 5/25/16.
//
//

#if canImport(UIKit)
import UIKit

import Swiftest

public extension UIViewController {
    
    public func preloadView() {
        _ = view
    }
    public func preloadViewsRecursively() {
        preloadView()
        nestedChildren().callOnEach(UIViewController.preloadView)
    }

    public func loadViewsRecursivelyIfNeeded() {
        loadViewIfNeeded()
        nestedChildren().callOnEach(UIViewController.loadViewIfNeeded)
    }
    
}

extension Array where Element: UIViewController {
    public func loadViewIfNeeded() {
        callOnEach(UIViewController.loadViewIfNeeded)
    }
    public func loadViewsRecursivelyIfNeeded() {
        callOnEach(UIViewController.loadViewsRecursivelyIfNeeded)
    }

    public func preloadView() {
        callOnEach(UIViewController.preloadView)
    }
    public func preloadViewsRecursively() {
        callOnEach(UIViewController.preloadViewsRecursively)
    }
}
#endif
