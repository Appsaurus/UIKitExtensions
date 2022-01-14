//
//  UITextFieldExtensions.swift
//  Pods
//
//  Created by Brian Strobach on 4/28/16.
//
//

#if canImport(UIKit)
import UIKit

extension UIColor {
    public static var systemPlaceholder: UIColor {
        return UIColor(red: 199, green: 199, blue: 205, alpha: 1.0)
    }
}

extension UIFont {
    public static var systemPlaceholder: UIFont {
        return UIFont(name: "HelveticaNeue-Medium", size: 16.0)!
    }
}
public extension UITextField {
    var fontSize: CGFloat {
        set {
            if let font = self.font {
                self.font = font.withSize(newValue)
            } else {
                self.font = UIFont.systemFont(ofSize: newValue)
            }
        }
        get {
            return self.font?.pointSize ?? UIFont.systemFontSize
        }
    }
    
    var fontName: String {
        set {
            self.font = UIFont(name: newValue, size: fontSize)
        }
        get {
            return self.font?.familyName ?? UIFont.systemFont(ofSize: fontSize).familyName
        }
    }
    
    func adjustFontSizeToFit(height: CGFloat) {
        guard let text = text else { return }
        font = font?.sizedToFit(text: text, inHeight: height)
    }
    
    func adjustFontSizeToFitHeight(scaleFactor: CGFloat = 1.0) {
        adjustFontSizeToFit(height: textRect(forBounds: bounds).h * scaleFactor)
    }
    
    /// A Boolean value that determines whether the textfield is being edited or is selected.
    var isEditingOrSelected: Bool {
        return isEditing || isSelected
    }
    
    @IBInspectable var placeholderColor: UIColor {
        get {
            return self.attributedPlaceholder?.attribute(.foregroundColor, at: 0, effectiveRange: nil) as? UIColor ?? .systemPlaceholder
        }
        set {
            attributedPlaceholder = currentPlaceholder?.setColor(newValue).setFont(placeholderFont)
        }
    }
    
    var placeholderFont: UIFont {
        get {            
            return self.attributedPlaceholder?.attribute(.font, at: 0, effectiveRange: nil) as? UIFont ?? .systemPlaceholder
        }
        set {
            attributedPlaceholder = currentPlaceholder?.setFont(newValue).setColor(placeholderColor)
        }
    }
    private var currentPlaceholder: NSMutableAttributedString? {
        return (attributedPlaceholder ?? placeholder?.attributed)?.mutable
    }
    
}

extension UITextField {
    
    public enum TextFieldAccessoryViewPosition {
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
        _ = view.leftAnchor.constraint(equalTo: outerView.leftAnchor, constant: insets.left)
        switch position {
        case .left:
            leftView = outerView
            leftViewMode = viewMode
        case .right:
            rightView = outerView
            rightViewMode = viewMode
        }
        self.contentMode = contentMode
    }
    
    public func hideCaret() {
        setCaret(color: .clear)
    }
    
    public func setCaret(color: UIColor) {
        tintColor = color
        tintAdjustmentMode = .normal
    }
}
#endif
