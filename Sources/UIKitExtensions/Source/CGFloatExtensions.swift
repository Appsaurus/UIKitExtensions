//
//  CGFloatExtensions.swift
//  UIKitExtensions
//
//  Created by Brian Strobach on 10/19/16.
//
//

#if canImport(UIKit) && !os(watchOS)
import UIKit
import Swiftest

public extension CGFloatConvertible {
    var scaledToPoints: CGFloat {
        return self.cgFloat / UIScreen.main.scale
    }

    var scaledToPixels: CGFloat {
        return self.cgFloat * UIScreen.main.scale
    }
}
#endif
