//
//  UITabBarControllerExtensions.swift
//  AppsaurusUIKit
//
//  Created by Brian Strobach on 10/23/17.
//

import Foundation
import UIKit
extension UITabBarController {
    public var contentView: UIView? {
        return view.subviews[0]        
    }
}
