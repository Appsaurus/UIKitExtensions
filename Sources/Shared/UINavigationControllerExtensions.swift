//
//  UINavigationControllerExtensions.swift
//  Pods
//
//  Created by Brian Strobach on 4/17/16.
//
//

import UIKit
import DinoDNA
public extension UINavigationController {
    
    
    /**
     Pushes a UIViewController onto the stack and runs a completion handler after the animation has finished.
     
     - parameter viewController: UIViewController to be pushed onto the stack
     - parameter animated:       Whether or not the push should be animated
     - parameter completion:     Closure to run after push has finished
     */
    public func pushViewController(_ viewController: UIViewController, animated: Bool, completion: @escaping VoidClosure) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
    
    public var previousViewController: UIViewController? {
        guard viewControllers.count > 1 else {
            return nil
        }
        return viewControllers[viewControllers.count - 2]
    }
}
