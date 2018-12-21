//
//  UIButtonExtensions.swift
//  Pods
//
//  Created by Brian Strobach on 4/28/16.
//
//

#if canImport(UIKit)
import UIKit

public extension UIButton {
    public var fontSize: CGFloat {
        set {
            if let font = self.titleLabel?.font {
                self.titleLabel?.font = font.withSize(newValue)
            } else {
                self.titleLabel?.font = UIFont.systemFont(ofSize: newValue)
            }
        }
        get {
            return self.titleLabel?.font.pointSize ?? UIFont.systemFontSize
        }
    }
    
    public var fontName: String {
        set {
            self.titleLabel?.font = UIFont(name: newValue, size: fontSize)
        }
        get {
            return self.titleLabel?.font?.familyName ?? UIFont.systemFont(ofSize: fontSize).familyName
        }
    }
    
    public var disabled: Bool {
        set {
            isEnabled = !newValue
        }
        get {
            return !isEnabled
        }
    }
}

public extension UIButton {
    
    public func setTitleColor(_ color: UIColor) {
        setTitleColor(color, for: .normal)
    }
    
    public func setTitle(_ title: String, forStates states: [UIControl.State]) {
        for state in states {
            setTitle(title, for: state)
        }
    }
    
    public func setAttributedTitle(_ title: NSAttributedString, forStates states: [UIControl.State]) {
        for state in states {
            setAttributedTitle(title, for: state)
        }
    }
    
    public func setAttributedTitle(_ title: String, font: UIFont? = nil, color: UIColor? = nil, forStates states: [UIControl.State]) {
        for state in states {
            setAttributedTitle(title, font: font, color: color, forState: state)
        }
    }
    public func setAttributedTitle(_ title: String, font: UIFont? = nil, color: UIColor? = nil, forState state: UIControl.State) {
        let attribTitle = NSMutableAttributedString.attributedString(title, font: font, color: color)
        setAttributedTitle(attribTitle, for: state)
    }
    
    public func alignImageToLeftAndCenterTitle(_ leftPadding: CGFloat = 10.0, centerInEntireFrame: Bool = true) {
        imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        contentEdgeInsets = UIEdgeInsets.zero
        contentHorizontalAlignment = .left
        imageEdgeInsets = UIEdgeInsets(top: 0, left: leftPadding, bottom: 0, right: 0)
        let imageWidth = imageEdgeInsets.left + imageView!.frame.size.width
        var widthToSpanLabel = frame.size.width
        if centerInEntireFrame {
            widthToSpanLabel -= imageWidth - imageEdgeInsets.left
        }
        let titleWidth = titleLabel?.frame.size.width ?? 0.0
        let leftInsetForTitleLabel = (widthToSpanLabel - titleWidth) / 2.0
        titleEdgeInsets = UIEdgeInsets(top: 0.0, left: leftInsetForTitleLabel, bottom: 0.0, right: 0.0)
    }
    
    public func centerTitle(_ contentInsets: UIEdgeInsets = UIEdgeInsets(top: 5.0, left: 10.0, bottom: 5.0, right: 10.0)) {
        titleLabel?.textAlignment = .center
        contentHorizontalAlignment = .center
        titleEdgeInsets = UIEdgeInsets.zero
        imageEdgeInsets = UIEdgeInsets.zero
        contentEdgeInsets = contentInsets
        
    }
    
}
#endif
