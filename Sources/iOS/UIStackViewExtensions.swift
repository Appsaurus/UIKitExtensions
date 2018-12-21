//
//  UIStackViewExtensions.swift
//  Pods
//
//  Created by Brian Strobach on 8/10/16.
//
//

#if canImport(UIKit)
import UIKit

@available(iOS 9.0, *)
public struct StackViewConfiguration {
    
    public var axis: NSLayoutConstraint.Axis
    public var distribution: UIStackView.Distribution
    public var alignment: UIStackView.Alignment
    public var spacing: CGFloat
    
    static public var defaultSpacing: CGFloat = 10.0
    
    //Horizontal
    static public func fillHorizontal(alignment: UIStackView.Alignment = .fill, spacing: CGFloat = defaultSpacing) -> StackViewConfiguration {
        return StackViewConfiguration(axis: .horizontal, distribution: .fill, alignment: alignment, spacing: spacing)
    }
    static public func fillEquallyHorizontal(alignment: UIStackView.Alignment = .fill, spacing: CGFloat = defaultSpacing) -> StackViewConfiguration {
        return StackViewConfiguration(axis: .horizontal, distribution: .fillEqually, alignment: alignment, spacing: spacing)
    }
    static public func fillProportionatelyHorizontal(alignment: UIStackView.Alignment = .center, spacing: CGFloat = defaultSpacing) -> StackViewConfiguration {
        return StackViewConfiguration(axis: .horizontal, distribution: .fillProportionally, alignment: alignment, spacing: spacing)
    }
    static public func equalSpacingHorizontal(alignment: UIStackView.Alignment = .leading, spacing: CGFloat = defaultSpacing) -> StackViewConfiguration {
        return StackViewConfiguration(axis: .horizontal, distribution: .equalSpacing, alignment: alignment, spacing: spacing)
    }
    
    //Vertical
    static public func fillVertical(alignment: UIStackView.Alignment = .fill, spacing: CGFloat = defaultSpacing) -> StackViewConfiguration {
        return StackViewConfiguration(axis: .vertical, distribution: .fill, alignment: alignment, spacing: spacing)
    }
    static public func fillEquallyVertical(alignment: UIStackView.Alignment = .fill, spacing: CGFloat = defaultSpacing) -> StackViewConfiguration {
        return StackViewConfiguration(axis: .vertical, distribution: .fillEqually, alignment: alignment, spacing: spacing)
    }
    static public func fillProportionatelyVertical(alignment: UIStackView.Alignment = .fill, spacing: CGFloat = defaultSpacing) -> StackViewConfiguration {
        return StackViewConfiguration(axis: .vertical, distribution: .fillProportionally, alignment: alignment, spacing: spacing)
    }
    static public func equalSpacingVertical(alignment: UIStackView.Alignment = .leading, spacing: CGFloat = defaultSpacing) -> StackViewConfiguration {
        return StackViewConfiguration(axis: .vertical, distribution: .equalSpacing, alignment: alignment, spacing: spacing)
    }
}

@available(iOS 9.0, *)
extension UIStackView {
    
    public convenience init(frame: CGRect = .zero, stackViewConfiguration config: StackViewConfiguration, arrangedSubviews: [UIView] = []) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.frame = frame
        apply(stackViewConfiguration: config)
    }
    
    public func apply(stackViewConfiguration config: StackViewConfiguration) {
        alignment = config.alignment
        spacing = config.spacing
        distribution = config.distribution
        axis = config.axis
    }
}

@available(iOS 9.0, *)
public extension UIStackView {
    public func addArrangedSubviews(_ views: [UIView]) {
        views.forEach {addArrangedSubview($0)}
    }
    
    public func clearArrangedSubviews(removeFromSuperView: Bool = true) {
        removeArrangedSubviews(arrangedSubviews, removeFromSuperview: removeFromSuperView)
    }
    
    public func swapArrangedSubviews(for arrangedSubviews: [UIView], removeFromSuperView: Bool = true) {
        clearArrangedSubviews(removeFromSuperView: removeFromSuperView)
        UIView.performWithoutAnimation {
            addArrangedSubviews(arrangedSubviews)            
        }
    }
    
    public func removeArrangedSubview(_ view: UIView, removeFromSuperview: Bool = true) {
        removeArrangedSubview(view)
        if removeFromSuperview == true {
            view.removeFromSuperview()
        }
    }
    
    public func removeArrangedSubviews(_ views: [UIView], removeFromSuperview: Bool = true) {
        views.forEach {
            removeArrangedSubview($0, removeFromSuperview: removeFromSuperview)
        }
    }
    
    public func replaceArrangedSubview(at index: Int, with subview: UIView, removeFromSuperview: Bool = true) {
        guard let view = arrangedSubviews[safe: index] else { return }
        removeArrangedSubview(view, removeFromSuperview: removeFromSuperview)
        insertArrangedSubview(subview, at: index)
    }
    
    public func replaceArrangedSubview(subview: UIView, with newSubview: UIView, removeFromSuperview: Bool = true) {
        guard let index = arrangedSubviews.index(of: subview) else { return }
        removeArrangedSubview(subview, removeFromSuperview: removeFromSuperview)
        insertArrangedSubview(newSubview, at: index)
        
    }
    
    public func removeArrangedSubview(at index: Int, removeFromSuperview: Bool = true) {
        let subview = arrangedSubviews[index]
        removeArrangedSubview(subview, removeFromSuperview: removeFromSuperview)
    }
    
    public func removeArrangedSubviews(after index: Int, removeFromSuperview: Bool = true) {
        for idx in (index + 1...arrangedSubviews.count - 1).reversed() {
            removeArrangedSubview(at: idx, removeFromSuperview: removeFromSuperview)
        }
    }
}
#endif
