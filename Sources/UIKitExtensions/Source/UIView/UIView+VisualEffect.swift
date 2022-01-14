//
//  UIView+VisualEffect.swift
//  UIKitExtensions
//
//  Created by Brian Strobach on 12/28/18.
//  Copyright © 2018 Brian Strobach. All rights reserved.
//

#if canImport(UIKit)
import UIKit

public extension UIView {

    @discardableResult
    func setBackgroundBlur(style: UIBlurEffect.Style) -> UIVisualEffectView {
        return setBackground(effect: UIBlurEffect(style: style))
    }

    @discardableResult
    func setBackground(effect: UIVisualEffect) -> UIVisualEffectView {
        let effectView = UIVisualEffectView(effect: effect)
        effectView.frame = bounds
        effectView.autoresizingMask = .flexibleSize
        insertSubview(effectView, at: 0)
        backgroundColor = .clear
        return effectView
    }
}

#endif
