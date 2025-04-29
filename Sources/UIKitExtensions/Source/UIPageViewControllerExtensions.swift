//
//  UIPageViewControllerExtensions.swift
//  UIKitExtensions
//
//  Created by Brian Strobach on 8/10/17.
//
//

import Foundation
#if canImport(UIKit)
import UIKit

extension UIPageViewController {
    public func hidePageControl(hideBottomSpace: Bool = true) {
//        view.subviews.forEach(where: {$0 is UIPageControl}, body: {$0.isHidden = true})
        pageControl?.isHidden = true
        view.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height + 40)
    }

    public var pageControl: UIPageControl? {
        return view.subviews(ofType: UIPageControl.self).first
    }
}
#endif
