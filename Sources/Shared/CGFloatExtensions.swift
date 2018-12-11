//
//  CGFloatExtensions.swift
//  Pods
//
//  Created by Brian Strobach on 10/19/16.
//
//

import Foundation
import DinoDNA

public extension DoubleConvertible {
    public var scaledToPoints: CGFloat {
        return self.toCGFloat / UIScreen.main.scale
    }
    
    public var scaledToPixels: CGFloat {
        return self.toCGFloat * UIScreen.main.scale
    }
    
}
