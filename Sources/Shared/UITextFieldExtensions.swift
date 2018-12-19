//
//  UITextFieldExtensions.swift
//  Pods
//
//  Created by Brian Strobach on 4/28/16.
//
//

import UIKit

public extension UITextField{
    public var fontSize: CGFloat{
        set{
            if let font = self.font{
                self.font = font.withSize(newValue)
            }
            else{
                self.font = UIFont.systemFont(ofSize: newValue)
            }
        }
        get{
            return self.font?.pointSize ?? UIFont.systemFontSize
        }
    }
    
    public var fontName: String{
        set{
            self.font = UIFont(name: newValue, size: fontSize)
        }
        get{
            return self.font?.familyName ?? UIFont.systemFont(ofSize: fontSize).familyName
        }
    }
    
    public func adjustFontSizeToFit(height: CGFloat){
        guard let text = text else { return }
        font = font?.sizedToFit(text: text, inHeight: height)
    }
    
    public func adjustFontSizeToFitHeight(scaleFactor: CGFloat = 1.0){
        adjustFontSizeToFit(height: textRect(forBounds: bounds).h * scaleFactor)
    }
    
    /// A Boolean value that determines whether the textfield is being edited or is selected.
    public var isEditingOrSelected: Bool {
        return isEditing || isSelected
    }
    
    @IBInspectable public var placeholderColor: UIColor {
        get {
            return self.attributedPlaceholder?.attribute(.foregroundColor, at: 0, effectiveRange: nil) as? UIColor ??  UIColor(red: 199, green:199, blue: 205, alpha: 1.0) //System placeholder color
        }
        set {
            self.attributedPlaceholder =  (self.attributedPlaceholder?.mutable ?? self.placeholder?.attributed.mutable)?.setColor(newValue).setFont(placeholderFont)
        }
    }
    
    @IBInspectable public var placeholderFont: UIFont {
        get {
            
            return self.attributedPlaceholder?.attribute(.font, at: 0, effectiveRange: nil) as? UIFont ?? UIFont(name: "HelveticaNeueu-Medium", size: 16.0)! //System placeholder color
        }
        set {
            self.attributedPlaceholder = (self.attributedPlaceholder?.mutable ?? self.placeholder?.attributed.mutable)?.setFont(newValue).setColor(placeholderColor)
        }
    }
    
}

extension UITextField {
    
    public enum TextFieldAccessoryViewPosition{
        case left, right
    }
    public func setupAccessoryView(_ view: UIView,
                                   position: TextFieldAccessoryViewPosition = .left,
                                   viewMode: UITextField.ViewMode = .always,
                                   insets: UIEdgeInsets = .zero,
                                   size: CGSize? = nil) {
        let size = size ?? CGSize(side: self.font?.pointSize ?? (frame.size.height * 0.75))
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: size.width + insets.left + insets.right, height: size.height + insets.top + insets.bottom))
        view.frame.size = size
        outerView.addSubview(view)
        view.leftAnchor.constraint(equalTo: outerView.leftAnchor, constant: insets.left)
        switch position{
        case .left:
            leftView = outerView
            leftViewMode = viewMode
        case .right:
            rightView = outerView
            rightViewMode = viewMode
        }
        self.contentMode = contentMode
    }

    
    public func hideCaret(){
        setCaret(color: .clear)
    }
    
    public func setCaret(color: UIColor){
        tintColor = color
        tintAdjustmentMode = .normal
    }
}
