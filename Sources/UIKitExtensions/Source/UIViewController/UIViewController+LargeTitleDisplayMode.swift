//
//  UIViewController+LargeTitleDisplayMode.swift
//  
//
//  Created by Brian Strobach on 9/28/22.
//

#if canImport(UIKit)
import UIKit

public extension UIViewController {

    @available(iOS 11.0, *)
    func setPrefersLargeTitleDisplay(mode: UINavigationItem.LargeTitleDisplayMode = .always) {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = mode
    }

    @available(iOS 14.0, *)
    func setBackButtonDisplay(mode: UINavigationItem.BackButtonDisplayMode) {
        navigationItem.backButtonDisplayMode = mode
    }
}
#endif
