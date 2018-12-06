//
//  UIEdgeInsetExtensions.swift
//  Pods
//
//  Created by Brian Strobach on 10/4/16.
//
//

import Foundation
import UIKit
public extension UIEdgeInsets{
    public init(padding: CGFloat){
        self.init(top: padding, left: padding, bottom: padding, right: padding)
    }
    
    public init(horizontalPadding: CGFloat = 0.0, verticalPadding: CGFloat = 0.0){
        self.init(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
    }
    
    public init(t: CGFloat = 0.0, l: CGFloat = 0.0, b: CGFloat = 0.0, r: CGFloat = 0.0){
        self.init(top: t, left: l, bottom: b, right: r)
    }

	public static func padded(_ padding: CGFloat) -> UIEdgeInsets{
		return UIEdgeInsets(padding: padding)
	}

	public static func padded(horizontal: CGFloat = 0.0, vertical: CGFloat = 0.0) -> UIEdgeInsets{
		return UIEdgeInsets(horizontalPadding: horizontal, verticalPadding: vertical)
	}

}
