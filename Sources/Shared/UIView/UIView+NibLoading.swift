//
//  UIView+NibLoading.swift
//  UIKitExtensions
//
//  Created by Brian Strobach on 12/27/18.
//  Copyright © 2018 Brian Strobach. All rights reserved.
//

#if canImport(UIKit)
import Swiftest
import UIKit

public extension UIView {

    /**
     Convenience method for instantiating views with a nib. Defaults to a nib that is named after the class.

     Example naming convention for default implementation: UICustomView -> UICustomView.xib

     Use type inference to help the compiler return the correct type of view.

     - parameter nibNameOrNil: The name of the nib to instantiate

     - returns: The instantiated view
     */
    class func fromNib<T: UIView>(_ nibName: String? = nil) -> T? {
        let nibName = nibName ?? self.className
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: nibName, bundle: bundle)
        // swiftlint:disable next force_cast
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! T
        return view
    }
}
#endif
