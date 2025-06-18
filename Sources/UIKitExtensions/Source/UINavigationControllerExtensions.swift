//
//  UINavigationControllerExtensions.swift
//  UIKitExtensions
//
//  Created by Brian Strobach on 4/17/16.
//
//

#if canImport(UIKit)
import UIKit
import Swiftest
public extension UINavigationController {
    
    func push(all viewControllers: [UIViewController], animated: Bool, completion: VoidClosure? = nil) {
            CATransaction.begin()
            CATransaction.setCompletionBlock(completion)
            self.setViewControllers(self.viewControllers + viewControllers, animated: animated)
            CATransaction.commit()
    }
    
    
    /**
     Pushes a UIViewController onto the stack and runs a completion handler after the animation has finished.
     
     - parameter viewController: UIViewController to be pushed onto the stack
     - parameter animated:       Whether or not the push should be animated
     - parameter completion:     Closure to run after push has finished
     */
    func pushViewController(_ viewController: UIViewController, animated: Bool, completion: @escaping VoidClosure) {
        pushViewController(viewController, animated: animated)

        if animated, let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        } else {
            completion()
        }
    }



    func popViewController(animated: Bool, completion: @escaping VoidClosure) {
        popViewController(animated: animated)

        if animated, let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        } else {
            completion()
        }
    }

    
    var previousViewController: UIViewController? {
        guard viewControllers.count > 1 else {
            return nil
        }
        return viewControllers[viewControllers.count - 2]
    }
}
#endif
