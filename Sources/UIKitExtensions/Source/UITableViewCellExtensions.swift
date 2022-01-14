//
//  UITableViewCellExtensions.swift
//  Pods
//
//  Created by Brian Strobach on 9/15/16.
//
//

#if canImport(UIKit)
import UIKit

public extension UITableViewCell {
    func applyClearBackground() {
        backgroundColor = UIColor.clear
        backgroundView?.backgroundColor = UIColor.clear
    }
    
    func hideSeparatorInset() {
        self.layoutMargins = UIEdgeInsets.zero
        self.separatorInset = UIEdgeInsets.zero
    }
    
    func setSelectedBackground(color: UIColor?) {
        guard let color = color else {
            self.selectedBackgroundView = nil
            return
        }
        let bgView = UIView()
        bgView.backgroundColor = color
        self.selectedBackgroundView = bgView
    }
}

public extension UIView {
    class var defaultReuseIdentifier: String {
        return className + "Identifier"
    }
}
#endif
