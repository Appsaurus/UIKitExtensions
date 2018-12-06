//
//  UIStackViewExtensions.swift
//  Pods
//
//  Created by Brian Strobach on 8/10/16.
//
//

import UIKit


@available(iOS 9.0, *)
public extension UIStackView{
    public func addArrangedSubviews(_ views: [UIView]){
        views.forEach{addArrangedSubview($0)}
    }
    
    public func clearArrangedSubviews(removeFromSuperView: Bool = true){
        removeArrangedSubviews(arrangedSubviews, removeFromSuperview: removeFromSuperView)
    }
    
    public func swapArrangedSubviews(for arrangedSubviews: [UIView], removeFromSuperView: Bool = true){
        clearArrangedSubviews(removeFromSuperView: removeFromSuperView)
        UIView.performWithoutAnimation {
            addArrangedSubviews(arrangedSubviews)            
        }
    }
    
    public func removeArrangedSubview(_ view: UIView, removeFromSuperview: Bool = true){
        removeArrangedSubview(view)
        if removeFromSuperview == true{
            view.removeFromSuperview()
        }
    }
    
    public func removeArrangedSubviews(_ views: [UIView], removeFromSuperview: Bool = true){
        views.forEach{
            removeArrangedSubview($0, removeFromSuperview: removeFromSuperview)
        }
    }
    
    public func replaceArrangedSubview(at index: Int, with subview: UIView, removeFromSuperview: Bool = true){
        guard let view = arrangedSubviews[safe: index] else { return }
        removeArrangedSubview(view, removeFromSuperview: removeFromSuperview)
        insertArrangedSubview(subview, at: index)
    }
    
    public func replaceArrangedSubview(subview: UIView, with newSubview: UIView, removeFromSuperview: Bool = true){
        guard let index = arrangedSubviews.index(of: subview) else { return }
        removeArrangedSubview(subview, removeFromSuperview: removeFromSuperview)
        insertArrangedSubview(newSubview, at: index)
        
    }
    
    public func removeArrangedSubview(at index: Int, removeFromSuperview: Bool = true){
        let subview = arrangedSubviews[index]
        removeArrangedSubview(subview, removeFromSuperview: removeFromSuperview)
    }
    
    public func removeArrangedSubviews(after index: Int, removeFromSuperview: Bool = true){
        for i in (index + 1...arrangedSubviews.count - 1).reversed(){
            removeArrangedSubview(at: i, removeFromSuperview: removeFromSuperview)
        }
    }
    
    
}
