//
//  UIViewController+HidedBackButtonTitle.swift
//  GiftAMeal
//
//  Created by Brian Strobach on 9/20/22.
//

#if canImport(UIKit)
import UIKit

public extension UIViewController {
    @available(iOS 11.0, *)
    func hideBackButtonTitle() {
        if #available(iOS 14.0, *) {
            navigationItem.backButtonDisplayMode = .minimal
        }
        else {
            navigationItem.backButtonTitle = ""
        }
    }
}
#endif
