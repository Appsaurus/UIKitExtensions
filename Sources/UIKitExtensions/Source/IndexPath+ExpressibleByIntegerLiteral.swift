//
//  IndexPath+ExpressibleByIntegerLiteral.swift
//  UIKitExtensions-iOS
//
//  Created by Brian Strobach on 12/19/18.
//  Copyright © 2018 Brian Strobach. All rights reserved.
//

#if canImport(UIKit)
import UIKit

extension IndexPath: ExpressibleByIntegerLiteral {
    public typealias IntegerLiteralType = Int
    
    public init(integerLiteral value: Int) {
        self.init(item: value, section: 0)
    }
}
#endif
