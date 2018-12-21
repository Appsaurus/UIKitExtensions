//
//  UIPageViewControllerExtensions.swift
//  Pods
//
//  Created by Brian Strobach on 8/10/17.
//
//

import Foundation
#if canImport(UIKit)
import UIKit

extension UIPageViewController {
    public func hidePageControl(hideBottomSpace: Bool = true) {
        var subviews: [Any] = view.subviews
        var thisControl: UIPageControl?
        for index in 0..<subviews.count {
            if (subviews[index] is UIPageControl) {
                thisControl = (subviews[i] as? UIPageControl)
            }
        }
        thisControl?.isHidden = true
        view.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height + 40)
    }
}
#endif
