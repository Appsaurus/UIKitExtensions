//
//  UIViewControllerTransitionCoordinatorExtensions.swift
//  AppsaurusUIKit
//
//  Created by Brian Strobach on 11/28/18.
//

#if canImport(UIKit)
import UIKit

extension UIViewControllerTransitionCoordinator {
    public var toViewController: UIViewController {
        return viewController(forKey: .to)!
    }
    
    public var fromViewController: UIViewController {
        return viewController(forKey: .from)!
    }
}
#endif
