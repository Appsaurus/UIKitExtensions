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
    case top, bottom, bouncingBottom, bouncingTop, middle
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
            return .bouncingTop
        case verticalOffsetForTop:
            return .top
        case verticalOffsetForTop..<verticalOffsetForBottom:
            return .middle
        case verticalOffsetForBottom:
            return .bottom
        case verticalOffsetForBottom..<999999999.99:
            return .bouncingBottom
        default:
            assertionFailure("Missing case")
            return .top
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
        return [.bottom, .bouncingBottom].contains(yOffsetPosition)
    }
    
    public var hasReachedTopOfContent: Bool{
        return [.top, .bouncingTop].contains(yOffsetPosition)
    }
}
#endif
