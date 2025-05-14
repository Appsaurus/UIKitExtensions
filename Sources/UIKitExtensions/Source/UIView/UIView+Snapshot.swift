//
//  UIView+Snapshot.swift
//  UIKitExtensions
//
//  Created by Brian Strobach on 5/14/25.
//


public extension UIView {
    /// Create image snapshot of view.
    func snapshot(of rect: CGRect? = nil) -> UIImage {
        return UIGraphicsImageRenderer(bounds: rect ?? bounds).image { _ in
            drawHierarchy(in: bounds, afterScreenUpdates: true)
        }
    }
}
