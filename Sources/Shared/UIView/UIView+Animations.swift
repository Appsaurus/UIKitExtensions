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
//swiftlint:disable multiple_closures_with_trailing_closure
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

// MARK: Animation Extensions

public typealias AnimationCompletion = ((Bool) -> Void)

extension UIView {

    public func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }

    public func rotate(_ degrees: CGFloat, animated: Bool = false, duration: TimeInterval = 0.5, completion: VoidClosure? = nil) {

        if animated {
            UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseOut, animations: { [weak self] in

                self?.transform = CGAffineTransform(rotationAngle: degrees.degreesToRadians)

            }) { (_) in
                completion?()
            }
        } else {
            transform = CGAffineTransform(rotationAngle: degrees.degreesToRadians)
            completion?()
        }
    }

    public func startInfiniteFadeInOut(_ duration: TimeInterval = 0.8) {
        let targetAlpha: CGFloat = self.alpha > 0 ? 0 : 1
        UIView.animate(withDuration: duration,
                       delay: 0.0,
                       options: [UIView.AnimationOptions.autoreverse, UIView.AnimationOptions.repeat, UIView.AnimationOptions.beginFromCurrentState],
                       animations: { [weak self] in
                        self?.alpha = targetAlpha
            },
                       completion: nil)
    }

    public func stopInfiniteFadeInOut(_ finalAlpha: CGFloat, duration: TimeInterval = 0.8) {
        UIView.animate(withDuration: duration,
                       delay: 0.0,
                       options: [UIView.AnimationOptions.beginFromCurrentState],
                       animations: { [weak self] in
                        self?.alpha = finalAlpha
            },
                       completion: {[weak self] (_) in
                        self?.layer.removeAllAnimations()
        })
    }

    public func hide(_ duration: TimeInterval = 0.3, delay: TimeInterval = 0.0, completion: VoidClosure? = nil) {
        animateAlpha(duration, delay: delay, toValue: 0.0, completion: completion)
    }

    public func show(_ duration: TimeInterval = 0.3, delay: TimeInterval = 0.0, completion: VoidClosure? = nil) {
        animateAlpha(duration, delay: delay, toValue: 1.0, completion: completion)
    }

    public func animateAlpha(_ duration: Double, delay: Double, toValue: CGFloat, completion: VoidClosure? = nil) {
        if toValue > 0 {
            self.isHidden = false
        }

        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseOut, animations: {[weak self] () -> Void in
            self?.alpha = toValue
        }) {[weak self] (finished) -> Void in
            if finished {
                if toValue == 0.0 {
                    self?.isHidden = true
                }
                completion?()
            }
        }
    }

    public func animateConstraintChanges(_ changes: VoidClosure? = nil,
                                         configuration: AnimationConfiguration = .default,
                                         additionalAnimations: VoidClosure? = nil,
                                         completion: VoidClosure? = nil) {
        UIView.animateConstraintChanges(changes, of: [self], configuration: configuration, additionalAnimations: additionalAnimations, completion: completion)
    }

    class public func animateConstraintChanges(_ changes: VoidClosure? = nil,
                                               of views: [UIView],
                                               configuration: AnimationConfiguration = .default,
                                               additionalAnimations: VoidClosure? = nil,
                                               completion: VoidClosure? = nil) {
        changes?()
        animate(configuration: configuration, layoutViews: views, animations: additionalAnimations, completion: completion)
    }

    public func animate(configuration: AnimationConfiguration = .default, animations: VoidClosure? = nil, completion: VoidClosure? = nil) {
        UIView.animate(configuration: configuration, layoutViews: [self], animations: animations, completion: completion)
    }

    class public func animate(configuration: AnimationConfiguration = .default,
                              layoutViews views: [UIView]? = nil,
                              animations: VoidClosure? = nil,
                              completion: VoidClosure? = nil) {
        UIView.animate(withDuration: configuration.duration, delay: configuration.delay, options: configuration.options, animations: {
            animations?()
            views?.forEach {$0.layoutIfNeeded()}

        }) { (finished) -> Void in
            if finished {
                completion?()
            }
        }
    }

    class public func animate(configuration: SpringAnimationConfiguration = .default,
                              layoutViews views: [UIView]? = nil,
                              animations: VoidClosure? = nil,
                              completion: VoidClosure? = nil) {
        UIView.animate(withDuration: configuration.duration,
                       delay: configuration.delay,
                       usingSpringWithDamping: configuration.springDamping,
                       initialSpringVelocity: configuration.springVelocity,
                       options: configuration.options,
                       animations: {
                        views?.forEach {$0.layoutIfNeeded()}
                        animations?()
        }) { (finished) -> Void in
            if finished {
                completion?()
            }
        }
    }

    public func springAnimate(configuration: SpringAnimationConfiguration = .default, animations: VoidClosure? = nil, completion: VoidClosure? = nil) {
        UIView.springAnimate(configuration: configuration, layoutViews: [self], animations: animations, completion: completion)
    }

    public func springAnimateConstraintChanges(_ changes: VoidClosure? = nil,
                                               configuration: SpringAnimationConfiguration = .default,
                                               additionalAnimations: VoidClosure? = nil,
                                               completion: VoidClosure? = nil) {
        UIView.springAnimateConstraintChanges(changes, of: [self], configuration: configuration, additionalAnimations: additionalAnimations, completion: completion)
    }

    class public func springAnimateConstraintChanges(_ changes: VoidClosure? = nil,
                                                     of views: [UIView],
                                                     configuration: SpringAnimationConfiguration = .default,
                                                     additionalAnimations: VoidClosure? = nil, completion: VoidClosure? = nil) {
        changes?()
        springAnimate(configuration: configuration, layoutViews: views, animations: additionalAnimations, completion: completion)
    }

    class public func springAnimate(configuration: SpringAnimationConfiguration = .default,
                                    layoutViews views: [UIView]? = nil,
                                    animations: VoidClosure? = nil,
                                    completion: VoidClosure? = nil) {

        UIView.animate(withDuration: configuration.duration,
                       delay: configuration.delay,
                       usingSpringWithDamping: configuration.springDamping,
                       initialSpringVelocity: configuration.springVelocity,
                       options: configuration.options,
                       animations: {
                        views?.forEach {$0.layoutIfNeeded()}
                        animations?()
        }) { (finished) -> Void in
            if finished {
                completion?()
            }
        }
    }
}

public class AnimationConfiguration {
    public static var `default`: AnimationConfiguration = AnimationConfiguration()

    public var duration: TimeInterval
    public var delay: TimeInterval
    public var options: UIView.AnimationOptions

    public init(duration: TimeInterval = 0.3, delay: TimeInterval = 0.0, options: UIView.AnimationOptions = []) {
        self.duration = duration
        self.delay = delay
        self.options = options
    }
}

public class SpringAnimationConfiguration {
    public static var `default`: SpringAnimationConfiguration = SpringAnimationConfiguration()

    public var duration: TimeInterval
    public var delay: TimeInterval
    public var options: UIView.AnimationOptions
    public var springDamping: CGFloat
    public var springVelocity: CGFloat

    public init(duration: TimeInterval = 0.3, delay: TimeInterval = 0.0, springDamping: CGFloat = 0.5, springVelocity: CGFloat = 0.8, options: UIView.AnimationOptions = []) {
        self.duration = duration
        self.delay = delay
        self.options = options
        self.springDamping = springDamping
        self.springVelocity = springVelocity
    }

}
#endif
