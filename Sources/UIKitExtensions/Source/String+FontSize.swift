//
//  String+FontSize.swift
//  UIKitExtensions
//
//  Created by Brian Strobach on 12/19/18.
//  Copyright © 2018 Brian Strobach. All rights reserved.
//

#if canImport(UIKit)
import UIKit

extension String {
    public func size(with font: UIFont) -> CGSize {
        return (self as NSString).size(withAttributes: [NSAttributedString.Key.font: font])
    }
}

#endif
