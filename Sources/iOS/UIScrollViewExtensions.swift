//
//  UIScrollViewExtensions.swift
//  AppsaurusUIKit
//
//  Created by Brian Strobach on 6/7/16.
//  Copyright © 2016 Appsaurus LLC. All rights reserved.
//

#if canImport(UIKit)
import UIKit

public enum UIScrollViewOffsetPosition{
    case Top, Bottom, BouncingBottom, BouncingTop, Middle
}
public extension UIScrollView {
    
    public func scrollToTop(_ animated: Bool = true){
        setContentOffset(CGPoint(x: contentOffset.x, y: verticalOffsetForTop), animated: animated)
    }
    
    public func scrollToBottom(_ animated: Bool = true){
        setContentOffset(CGPoint(x: contentOffset.x, y: verticalOffsetForBottom), animated: animated)
    }

    //Note: 999999999.99 magic number is because CGFloat.min and max will crash this
    public var yOffsetPosition: UIScrollViewOffsetPosition{
        return self.calculateYOffsetPostition(for: contentOffset.y)
    }
    
    public func calculateYOffsetPostition(for offset: CGFloat) -> UIScrollViewOffsetPosition{
        switch offset{
        case -999999999.99..<verticalOffsetForTop:
            return .BouncingTop
        case verticalOffsetForTop:
            return .Top
        case verticalOffsetForTop..<verticalOffsetForBottom:
            return .Middle
        case verticalOffsetForBottom:
            return .Bottom
        case verticalOffsetForBottom..<999999999.99:
            return .BouncingBottom
        default:
            assertionFailure("Missing case")
            return .Top
        }
    }
    
    public var verticalOffsetForTop: CGFloat {
        let topInset = contentInset.top
        if topInset == 0.0{
            return topInset
        }
        return -topInset
    }
    
    public var verticalOffsetForBottom: CGFloat {
        let scrollViewHeight = bounds.height
        let scrollContentSizeHeight = contentSize.height
        let bottomInset = contentInset.bottom
        let scrollViewBottomOffset = scrollContentSizeHeight + bottomInset - scrollViewHeight
        return max(scrollViewBottomOffset, verticalOffsetForTop + 0.1)
    }
    
    public var hasReachedBottomOfContent: Bool{
        return [.Bottom, .BouncingBottom].contains(yOffsetPosition)
    }
    
    public var hasReachedTopOfContent: Bool{
        return [.Top, .BouncingTop].contains(yOffsetPosition)
    }
}
#endif
