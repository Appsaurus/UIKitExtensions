//
//  UIControlExtensions.swift
//  Pods
//
//  Created by Brian Strobach on 8/10/16.
//
//

import Foundation
import UIKit

//MARK: Adds closure alternative to target action to UIControl
open class CallbackHolder: NSObject {
    
    let callback: () -> Void
    
    init(callback: @escaping () -> Void) {
        self.callback = callback
    }
    
    @objc open func call() {
        callback()
    }
    
}

extension UIControl {
    fileprivate struct AssociatedKeys {
        static var CallbackHolderKey = "CallbackHolderKey"
    }
    
    fileprivate var callbackHolder: CallbackHolder? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.CallbackHolderKey) as? CallbackHolder
        }
        
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(
                    self,
                    &AssociatedKeys.CallbackHolderKey,
                    newValue as CallbackHolder?,
                    .OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
            }
        }
    }
    public func addAction(forControlEvents events: UIControl.Event, withCallback callback: @escaping () -> Void) {
        let holder: CallbackHolder = CallbackHolder(callback: callback)
        addTarget(holder, action: #selector(CallbackHolder.call), for: events)
        objc_setAssociatedObject(self, AssociatedKeys.CallbackHolderKey, holder, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) // prevent garbage collection
    }
    
}
