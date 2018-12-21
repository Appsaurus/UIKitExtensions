////
////  UIView+ActivityIndicator.swift
////  Pods
////
////  Created by Brian Strobach on 8/4/17.
////
////
//

// swiftlint:disable all
//import Foundation
//#if canImport(UIKit)
//import UIKit
//
//public enum ActivityIndicatorPosition{
//    case center, right, left
//}
//
//extension UIBarButtonItem{
//    public func showActivityIndicator(style: UIActivityIndicatorView.Style = .gray, position: ActivityIndicatorPosition = .center){
//        guard let customView = self.customView else {
//            assertionFailure("You can only show activity indicator on a UIBarButtonItem with a customView.")
//            return
//        }
//        customView.showActivityIndicator(style: style, useAutoLayout: false, position: position)
//    }
//    public func hideActivityIndicator(){
//        guard let customView = self.customView else {
//            assertionFailure("You can only show activity indicator on a UIBarButtonItem with a customView.")
//            return
//        }
//        customView.hideActivityIndicator()
//    }
//}
//
//extension UIView{
//    
//    
//    /**
//     Creates and starts animating a UIActivityIndicator in any UIView
//     Parameter style: `UIActivityIndicatorViewStyle` default is .Gray
//     */
//    
//    public func showActivityIndicator(style: UIActivityIndicatorView.Style = .gray, useAutoLayout: Bool = true, position: ActivityIndicatorPosition = .center){
//        if let indicator: UIActivityIndicatorView = self.subview(withTag: UIViewExtensionTag.activityIndicator) as? UIActivityIndicatorView { //Indicator already exists, make sure it is visible but do not create another
//            bringSubviewToFront(indicator)
//            indicator.startAnimating()
//            return
//        }
//        let indicator = UIActivityIndicatorView(style: style)
//        indicator.apply(viewStyle: self.viewStyle())
//        while let superview = superview, indicator.backgroundColor == .clear{
//            indicator.backgroundColor = superview.backgroundColor
//            indicator.cornerRadius = superview.cornerRadius
//        }
//        indicator.tag = UIViewExtensionTag.activityIndicator.rawValue
//        addSubview(indicator)
//        
//        if useAutoLayout{
//            switch position{
//            case .center:
//                indicator.autoPinToSuperview()
//            case .right:
//                indicator.autoPinToSuperview(excludingEdges: [.left])
//            case .left:
//                indicator.autoPinToSuperview(excludingEdges: [.right])                
//            }
//        }
//        else{
//            switch position{
//            case .center:
//                indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//                indicator.center = self.center
//                indicator.frame = bounds
//            case .right:
//                indicator.size = CGSize(side: h)
//                indicator.autoresizingMask = [.flexibleHeight]
//                indicator.center = CGPoint(x: w - (indicator.w / 2.0), y: h / 2.0)
//            case .left:
//                indicator.size = CGSize(side: h)
//                indicator.autoresizingMask = [.flexibleHeight]
//                indicator.center = CGPoint(x: indicator.w, y: h / 2.0)
//            }
//            
//        }
//        bringSubviewToFront(indicator)
//        indicator.startAnimating()
//    }
//    
//    /**
//     Stops and removes an UIActivityIndicator in any UIView
//     */
//    public func hideActivityIndicator(){
//        guard let indicator: UIActivityIndicatorView = self.subview(withTag: UIViewExtensionTag.activityIndicator) as? UIActivityIndicatorView else{
//            return
//        }
//        indicator.stopAnimating()
//        indicator.removeFromSuperview()
//    }
//}
