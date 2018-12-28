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

extension UIViewController {
    
    open func extendViewUnderNavigationBar() {
        edgesForExtendedLayout = [.top]
        extendedLayoutIncludesOpaqueBars = true
    }
    
    open func extendViewUnderTabBar() {
        edgesForExtendedLayout = [.bottom]
        extendedLayoutIncludesOpaqueBars = true
    }
    
    open func extendViewUnderBars() {
        edgesForExtendedLayout = [.top, .bottom]
        extendedLayoutIncludesOpaqueBars = true
    }
}
#endif
