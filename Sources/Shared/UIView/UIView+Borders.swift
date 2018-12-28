//
//  UIView+Borders.swift
//  UIKitExtensions
//
//  Created by Brian Strobach on 12/28/18.
//  Copyright © 2018 Brian Strobach. All rights reserved.
//

#if canImport(UIKit)
import UIKit

extension UIView {
    @discardableResult
    public func addBorder(edges: UIRectEdge,
                          color: UIColor = UIColor.white,
                          thickness: CGFloat = 1,
                          padding: CGFloat = 0.0) -> [UIView] {

        var thickness = thickness
        thickness = (thickness / UIScreen.main.scale)

        var borders = [UIView]()

        func border() -> UIView {
            let border = UIView(frame: CGRect.zero)
            border.backgroundColor = color
            return border
        }

        if edges.contains(.top) || edges.contains(.all) {
            let top = border()
            addSubview(top)
            top.topAnchor.constraint(equalTo: topAnchor, constant: padding)
            top.leftAnchor.constraint(equalTo: leftAnchor, constant: padding)
            top.rightAnchor.constraint(equalTo: rightAnchor, constant: padding)
            borders.append(top)
        }

        if edges.contains(.left) || edges.contains(.all) {
            let left = border()
            addSubview(left)
            left.topAnchor.constraint(equalTo: topAnchor, constant: padding)
            left.leftAnchor.constraint(equalTo: leftAnchor, constant: padding)
            left.bottomAnchor.constraint(equalTo: bottomAnchor, constant: padding)
            borders.append(left)
        }

        if edges.contains(.right) || edges.contains(.all) {
            let right = border()
            addSubview(right)
            right.topAnchor.constraint(equalTo: topAnchor, constant: padding)
            right.bottomAnchor.constraint(equalTo: bottomAnchor, constant: padding)
            right.rightAnchor.constraint(equalTo: rightAnchor, constant: padding)
            borders.append(right)
        }

        if edges.contains(.bottom) || edges.contains(.all) {
            let bottom = border()
            addSubview(bottom)
            bottom.bottomAnchor.constraint(equalTo: bottomAnchor, constant: padding)
            bottom.leftAnchor.constraint(equalTo: leftAnchor, constant: padding)
            bottom.rightAnchor.constraint(equalTo: rightAnchor, constant: padding)
            borders.append(bottom)
        }
        borders.forEach { (b) in
            b.heightAnchor.constraint(equalToConstant: thickness)
        }
        return borders
    }
}
#endif
