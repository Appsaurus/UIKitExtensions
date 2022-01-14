//
//  UIView+ToImage.swift
//  UIKitExtensions
//
//  Created by Brian Strobach on 12/28/18.
//  Copyright © 2018 Brian Strobach. All rights reserved.
//

#if canImport(UIKit)
import UIKit

extension UIView {

    public func toImage(transparentBackground: Bool? = nil) -> UIImage {
        guard #available(iOS 10.0, *) else {
            let opaque = transparentBackground != nil ? !transparentBackground! : isOpaque
            UIGraphicsBeginImageContextWithOptions(frame.size, opaque, 0.0)
            layer.render(in: UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return UIImage(cgImage: image!.cgImage!)
        }
        let renderer = UIGraphicsImageRenderer(size: frame.size)
        return renderer.image { _ in
            drawHierarchy(in: bounds, afterScreenUpdates: true)
        }
    }
}

#endif
