//
//  CGColorExtensions.swift
//  UIKitExtensions
//
//  Created by Brian Strobach on 12/11/18.
//  Copyright © 2018 Brian Strobach. All rights reserved.
//

import UIKit

extension CGColor{
    public var uiColor: UIColor{
        return UIColor(cgColor: self)
    }
}
