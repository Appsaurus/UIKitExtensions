//
//  UISearchBarExtensions.swift
//  Pods
//
//  Created by Brian Strobach on 8/10/16.
//
//

#if canImport(UIKit)
import UIKit

public extension UISearchBar {
    var textField: UITextField? {
        for subView in subviews {
            for subsubView in subView.subviews {
                if let textField = subsubView as? UITextField {
                    return textField
                }
                
            }
        }
        return nil
    }
    
    func setSearchIconColor(color: UIColor) {
        guard let glassIconView = textField?.leftView as? UIImageView else { return }
            glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
            glassIconView.tintColor = color
    }
    
    /// Wrapper for setting the tint color of the search bars text field, which controls the cursor color. May have side effects. Must be called after view has loaded.
    
    var cursorColor: UIColor? {
        get {
            return textField?.tintColor
        }
        set {
            textField?.tintColor = newValue
        }
    }
    
    func makeBackgroundTransparent() {
        backgroundImage = UIImage()
        isTranslucent = true
        setSearchFieldBackgroundImage(UIImage.image(ofColor: .clear, size: frame.size), for: .normal)
        backgroundColor = .clear
        barTintColor = .clear
    }
}

public extension UISearchBar {
    func searchQuery(filterEmpty: Bool = true) -> String? {
        let query = textField?.text
        return filterEmpty ? query.removeEmpty : query
    }

    func hasSearchQuery(filterEmpty: Bool = true) -> Bool {
        guard let _ = searchQuery(filterEmpty: filterEmpty) else { return false }
        return true
    }
}

#endif
