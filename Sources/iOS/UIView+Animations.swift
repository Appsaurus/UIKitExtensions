//
//  UIView+Animations.swift
//  Pods
//
//  Created by Brian Strobach on 8/4/17.
//
//

#if canImport(UIKit)
import UIKit
import Swiftest

extension UIView {
    
    public func wobble(duration: Double = 0.15,
                       count: Int? = nil,
                       indefinitely: Bool = false,
                       completion: VoidClosure? = nil) {
        let count = count
        let rand = (CGFloat((arc4random() % 500)) / 500.0) + 0.5
        let rotateDegree: CGFloat = 2.0
        let leftWobble = CGAffineTransform.identity.rotated(by: CGFloat((rotateDegree * -1 - rand).degreesToRadians.double))
        let rightWobble = CGAffineTransform.identity.rotated(by: CGFloat((rotateDegree + rand).degreesToRadians.double))
        self.transform = leftWobble
        var options = [UIView.AnimationOptions.allowUserInteraction, UIView.AnimationOptions.autoreverse]
        if indefinitely { options.append(UIView.AnimationOptions.repeat) }
        
        let config = AnimationConfiguration(duration: duration, options: UIView.AnimationOptions(options))
        animate(configuration: config,
                animations: {
            if !indefinitely, let repeatCount = count {
                UIView.setAnimationRepeatCount(Float(repeatCount))
            }
            self.transform = rightWobble
        }, completion: completion)
        
    }
    
    public func startWobbling() {
        wobble(indefinitely: true)
    }
    
    public func stopWobbling () {
        self.layer.removeAllAnimations()
        self.transform = CGAffineTransform.identity
    }

}
#endif
