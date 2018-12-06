//
//  CALayerExtensions.swift
//  Pods
//
//  Created by Brian Strobach on 8/10/16.
//
//

import Foundation
import UIKit

public extension CALayer{
    
    public func addGlowingShadow(_ color: UIColor, radius: CGFloat = 5.0, opacity: Float = 1.0, offset: CGSize = CGSize.zero){
        shadowColor = color.cgColor
        shadowRadius = radius
        shadowOpacity = opacity
        shadowOffset = offset
        masksToBounds = false
    }
    
    public func resetShadow(){
        shadowRadius = 3.0
        shadowOpacity = 0.0
        shadowOffset = CGSize(width: 0.0, height: -3.0)
    }
}
