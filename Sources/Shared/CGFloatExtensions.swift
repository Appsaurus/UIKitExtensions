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
        return CGFloat(self.double) / UIScreen.main.scale
    }
    
    public var scaledToPixels: CGFloat {
        return CGFloat(self.double) * UIScreen.main.scale
    }
    
}
