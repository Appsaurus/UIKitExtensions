//
//  UIView+MotionEffects.swift
//  UIKitExtensions-iOS
//
//  Created by Brian Strobach on 12/21/21.
//  Copyright © 2021 Brian Strobach. All rights reserved.
//

#if canImport(UIKit)

import UIKit

public extension UIMotionEffect {
    static func centerParallax(offset: CGFloat = 10) -> UIMotionEffectGroup {
        let motionEffectsX = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        motionEffectsX.maximumRelativeValue = offset
        motionEffectsX.minimumRelativeValue = -offset

        let motionEffectsY = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        motionEffectsY.maximumRelativeValue = offset
        motionEffectsY.minimumRelativeValue = -offset

        let group = UIMotionEffectGroup()
        group.motionEffects = [motionEffectsX, motionEffectsY]
        return group
    }
}


#endif
