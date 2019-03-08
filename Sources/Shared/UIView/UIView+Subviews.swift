//
//  UIView+Subviews.swift
//  UIKitExtensions
//
//  Created by Brian Strobach on 12/27/18.
//  Copyright © 2018 Brian Strobach. All rights reserved.
//

#if canImport(UIKit)
import UIKit
import Swiftest

public extension UIView {

    public func animate(to destinationFrame: CGRect,
                        in destinationSuperview: UIView = UIApplication.mainWindow,
                        using configuration: AnimationConfiguration = .default,
                        additionalAnimations: VoidClosure? = nil,
                        completion: VoidClosure? = nil) {

        moveToMainWindow()
        animate(configuration: configuration, animations: { [weak self] in
            guard let self = self else { return }
            additionalAnimations?()
            self.frame = destinationSuperview.convert(destinationFrame, to: UIApplication.mainWindow)
            self.layoutIfNeeded()
            }, completion: { [weak self] in
                guard let self = self else { return }
                self.frame = destinationFrame
                destinationSuperview.addSubview(self)
                completion?()
        })
    }

    //swiftlint:disable:next todo
    //FIXME: This works for one animation on a view and scales nicely, but any subsequent animation on the same view seems to break. I think this has something to do with the transform no longer being equal to identity, and the frame no longer being valid after the first animation.
    public func animateTransform(to destinationFrame: CGRect,
                                 in destinationSuperview: UIView = UIApplication.mainWindow,
                                 using configuration: AnimationConfiguration = .default,
                                 additionalAnimations: VoidClosure? = nil,
                                 completion: VoidClosure? = nil) {

        moveToMainWindow()
        let widthScale = destinationFrame.w / frame.w
        let heightScale = destinationFrame.h / frame.h

        let scaleTransform = CGAffineTransform(scaleX: widthScale, y: heightScale)

        let offset = destinationFrame.center - center
        let translationTransform = CGAffineTransform(translationX: offset.x, y: offset.y)
        let finalTransform = scaleTransform.concatenating(translationTransform)

        animate(configuration: configuration, animations: { [weak self] in
            guard let self = self else { return }
            additionalAnimations?()
            self.transform = finalTransform
            }, completion: { [weak self] in
                guard let self = self else { return }
                self.frame = destinationFrame
                destinationSuperview.addSubview(self)
                completion?()
        })
    }
    public func addSubviews(_ views: UIView...) {
        views.forEach {addSubview($0)}
    }
    public func addSubviews(_ views: [UIView]) {
        views.forEach {addSubview($0)}
    }

    //Optional subiews

    public func addSubview(_ optionalSubview: UIView?) {
        guard let view = optionalSubview else { return }
        addSubview(view)
    }
    public func addSubviews(_ optionalSubviews: [UIView?]) {
        addSubviews(optionalSubviews.removeNils())
    }

    public func addSubviews(_ optionalSubviews: UIView?...) {
        addSubviews(optionalSubviews.removeNils())
    }
}
#endif
