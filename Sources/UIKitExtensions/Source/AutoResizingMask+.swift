//
//  AutoResizingMask+.swift
//  UIKitExtensions
//
//  Created by Brian Strobach on 12/28/18.
//  Copyright © 2018 Brian Strobach. All rights reserved.
//

#if canImport(UIKit)
import UIKit

extension UIView.AutoresizingMask {
    public static var flexibleSize: UIView.AutoresizingMask {
        return [.flexibleHeight, .flexibleWidth]
    }
}

#endif
