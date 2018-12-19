//
//  CGFloatExtensions.swift
//  Pods
//
//  Created by Brian Strobach on 10/19/16.
//
//

import Foundation
import Swiftest

public extension CGFloatConvertible {
    public var scaledToPoints: CGFloat {
        return self.cgFloat / UIScreen.main.scale
    }
    
    public var scaledToPixels: CGFloat {
        return self.cgFloat * UIScreen.main.scale
    }
    
}
