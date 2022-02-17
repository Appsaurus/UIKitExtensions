//
//  UIViewTags.swift
//  Pods
//
//  Created by Brian Strobach on 1/19/17.
//
//

import Foundation
#if canImport(UIKit)
import UIKit

public protocol UIViewTag: RawRepresentable {
    var rawValue: Int { get }
}

/// Tags for any views that are created by an extension method and need to be accessed at later time.
/// Used as an alternative to storing references in associated objects via obj-c runtime.
///
/// - activityIndicator: 1001
public enum UIViewExtensionTag: Int, UIViewTag {
    case activityIndicator = 1001
}

extension UIView {
    public func subview<VT: UIViewTag>(withTag tag: VT) -> UIView? {
        return viewWithTag(tag.rawValue)
    }
}
#endif
