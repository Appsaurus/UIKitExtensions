//
//  UIView+Framed.swift
//  UIKitExtensions
//
//  Created by Brian Strobach on 12/27/18.
//  Copyright © 2018 Brian Strobach. All rights reserved.
//

#if canImport(UIKit)
import Swiftest
import UIKit

extension UIView: Framed {

    public var w: CGFloat {
        get {
            return width
        } set(value) {
            size.w = value
        }
    }

    public var h: CGFloat {
        get {
            return height
        } set(value) {
            size.h = value
        }
    }
    
    public var origin: CGPoint {
        get {
            return frame.origin
        }
        set(newValue) {
            frame.origin = newValue
        }
    }

    public var minX: CGFloat {
        return frame.minX
    }

    public var maxX: CGFloat {
        return frame.maxX
    }

    public var midX: CGFloat {
        return frame.midX
    }

    public var minY: CGFloat {
        return frame.minY
    }

    public var maxY: CGFloat {
        return frame.maxY
    }

    public var midY: CGFloat {
        return frame.midY
    }

    public var width: CGFloat {
        return frame.width
    }

    public var height: CGFloat {
        return frame.height
    }

    public var size: CGSize {
        get {
            return frame.size
        }
        set(newValue) {
            frame.size = newValue
        }
    }
}
#endif
