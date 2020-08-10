//
//  UIViewController+EasyNavigation.swift
//  UIKitExtensions
//
//  Created by Brian Strobach on 12/28/18.
//  Copyright © 2018 Brian Strobach. All rights reserved.
//

#if canImport(UIKit)
import UIKit
import Swiftest

public extension UIViewController {

    func present(viewController: UIViewController, animated: Bool = true, completion: VoidClosure? = nil) {
        present(viewController, animated: animated, completion: completion)
    }

    func push(_ viewController: UIViewController, animated: Bool = true, completion: VoidClosure? = nil) {
        guard let navVC = self as? UINavigationController ?? self.navigationController else { return }
        guard let completion = completion else {
            navVC.pushViewController(viewController, animated: animated)
            return
        }
        navVC.pushViewController(viewController, animated: animated, completion: completion)
    }
    
    func pushOrPresent(_ viewController: UIViewController, animated: Bool = true, completion: VoidClosure? = nil) {
        guard let navVC = self as? UINavigationController ?? self.navigationController else {
            present(viewController: viewController, animated: animated, completion: completion)
            return
        }
        navVC.push(viewController, animated: animated, completion: completion)
    }

    func popOrDismiss(animated: Bool = true, completion: VoidClosure? = nil) {
        guard let nav = navigationController else {
            dismiss(animated: animated, completion: nil)
            return
        }
        nav.popViewController(animated: animated)
        completion?()
    }

    func dismiss(after delay: TimeInterval, animated: Bool = true, completion: VoidClosure? = nil) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.dismiss(animated: animated, completion: completion)
        }
    }
    func popOrDismiss(after delay: TimeInterval, animated: Bool = true, completion: VoidClosure? = nil) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.popOrDismiss(animated: animated, completion: completion)
        }
    }
}
#endif
