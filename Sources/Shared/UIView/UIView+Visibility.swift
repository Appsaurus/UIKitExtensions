//
//  UIView+Visibility.swift
//  UIKitExtensions-iOS
//
//  Created by Brian Strobach on 12/27/18.
//  Copyright © 2018 Brian Strobach. All rights reserved.
//

#if canImport(UIKit)
import UIKit
extension UIView {

    public var isVisible: Bool {
        set {
            isHidden = !newValue
        }
        get {
            return !isHidden
        }
    }

}

extension Array where Element: UIView {
    public var areHidden: Bool {
        get {
            return self.all(match: {$0.isHidden})
        }
        set {
            self.forEach({$0.isHidden = newValue})
        }
    }

    public var areVisible: Bool {
        get {
            return self.all(match: {$0.isVisible})
        }
        set {
            self.forEach({$0.isVisible = newValue})
        }
    }
}
#endif
