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
    
    public func add(_ child: UIViewController, to container: UIView) {
        child.view.frame = container.bounds
        container.addSubview(child.view)
        child.view.autoresizingMask = .flexibleSize
        child.willMove(toParent: self)
        addChild(child)
        child.didMove(toParent: self)
    }
    
    public func remove(_ child: UIViewController) {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
        child.didMove(toParent: nil)
    }
    
    public func swap(out oldChild: UIViewController,
                     with newChild: UIViewController,
                     into container: UIView? = nil,
                     animated: Bool = true,
                     completion: VoidClosure? = nil) {
        guard let container: UIView = container ?? oldChild.view?.superview ?? view else { return }
        remove(oldChild)
        add(newChild, to: container)
        completion?()
    }

    public func callOnNestedHeirachy(_ method: MethodOf<UIViewController>,
                                     includeSelf: Bool = true,
                                     childSearchConfiguration: ChildViewControllerSearchConfiguration = .all(recursive: true)) {
        if includeSelf { call(method, on: self) }
        nestedChildren(childSearchConfiguration).callOnEach(method)
    }

    public func nestedChildren(_ configuration: ChildViewControllerSearchConfiguration = .all(recursive: true)) -> [UIViewController] {
        var allChildren: [UIViewController] = children
        var managerTypes: [ViewControllerManagerType] = []
        var recursive: Bool = false
        switch configuration {
        case .recursiveChildren:
            recursive = true
        case .managedViewControllers(let types, let recurse):
            recursive = recurse
            managerTypes += types
        case .all(let recurse):
            recursive = recurse
            managerTypes += ViewControllerManagerType.allCases
        }
        for type in managerTypes {
            switch (type, self) {
            case (.navigationController, let navController as UINavigationController):
                allChildren += navController.viewControllers
            case (.tabBarController, let tabBarController as UITabBarController):
                allChildren += tabBarController.viewControllers ?? []
            case (.pageViewController, let pageViewController as UIPageViewController):
                allChildren += pageViewController.viewControllers ?? []
            default: break
            }
        }
        if recursive {
            let allChildrenCopy = allChildren
            for child in allChildrenCopy {
                allChildren += child.nestedChildren(configuration)
            }
        }
        return allChildren
    }
}

public enum ViewControllerManagerType: CaseIterable {
    case navigationController
    case tabBarController
    case pageViewController
}

public enum ChildViewControllerSearchConfiguration {
    case recursiveChildren //Recurses over .children (contained viewcontrollers only) and thier nested children
    case managedViewControllers(types: [ViewControllerManagerType], recursive: Bool) //Iterates  over Nav/Tab/PageViewControllers (and their nested children if recursive == true)
    case all(recursive: Bool) //Iterates over .children (contained) and Nav/Tab/PageViewControllers (and their nested children if recursive == true)
}
#endif
